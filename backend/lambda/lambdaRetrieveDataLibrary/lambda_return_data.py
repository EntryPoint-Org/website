import json
import os
import boto3
from botocore.exceptions import ClientError
import psycopg2
from psycopg2 import OperationalError, sql
from credentials import db_creds

def get_postgres_credentials(secret_Name) -> db_creds:

    client = boto3.client(
      service_name='secretsmanager',
      region_name=os.environ['AWS_REGION']
    )
    
    try:
        secret_value = client.get_secret_value(
            SecretId=secret_Name # replace with the real secret name 
        )
        secret = json.loads(secret_value['SecretString'])
    except ClientError as e:
        print(f"The error '{e}' occurred")
        raise e
    
    return db_creds(
        username = secret['username'],
        password = secret['password'],
        host = secret['host'],
        database = secret['database']
    )


def check_table(table):
    try:
        credential = get_postgres_credentials(secret_Name=os.environ["secret_name"]) # replace the secret with the actual secret for the DB creds
    except json.JSONDecodeError as e:
            return {
                'statusCode': 400,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps({"error": "Invalid JSON syntax", "message": str(e)})
            }
    
    # try to connect to the DB
    try:
        connection = psycopg2.connect(
            user=credential.username,
            password=credential.password,
            host=credential.host,
            database=credential.database,
            connect_timeout=10
        )
    except OperationalError as e:
        print(f"The error '{e}' occurred")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({"error": "Database connection failed", "message": str(e)})
        }

    try:  
        cursor = connection.cursor()
        
        check_table = sql.SQL("SELECT 1 FROM pg_tables WHERE tablename = %s")
        cursor.execute(check_table, (table,))
        table_exists = cursor.fetchone()

        if not table_exists:
            print(f"There is no table called {table}")
            return {
                'statusCode': 400,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps({"message": f"There is no table called {table}"})
            }
    except OperationalError as e:
        print(f"The error '{e}' occurred")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({"error": str(e)})
        }

