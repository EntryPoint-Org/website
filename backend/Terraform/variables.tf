variable "name" {
  type = string
  default = "github-entrypoint"
}

variable "provider_url" {
  type = string
  default = "https://token.actions.githubusercontent.com"
}

variable "audience" {
  type = string
  default = "sts.amazonaws.com"
}

variable "thumbprint" {
    type = string
    default = "1B511ABEAD59C6CE207077C0BF0E0043B1382612"
}
