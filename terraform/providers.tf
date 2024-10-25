variable "api_key" {}
variable "secret_key" {}

terraform {
  required_providers {
    cloudstack = {
      source = "cloudstack/cloudstack"
      version = "0.4.0"
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}

provider "cloudstack" {
  api_url    = "https://tky001b.pf.gmocloud.com/client/api"
  api_key    = "${var.api_key}"
  secret_key = "${var.secret_key}"
  http_get_only = true
}

