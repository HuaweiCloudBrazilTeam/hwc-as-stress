variable user_name {
  description = "Username da Huawei Cloud"
}

variable "password" {
  description = "Password da Huawei Cloud"
}

variable "domain_name" {
  default = "ClaroCloudTest"
}

variable "tenant_name" {
  default = "sa-brazil-1"
}

variable "region" {
  default = "sa-brazil-1"
}

provider "huaweicloud" {
  user_name   = var.user_name
  password    = var.password
  domain_name = var.domain_name
  tenant_name = var.tenant_name
  region      = var.region
  auth_url    = "https://iam.sa-brazil-1.myhuaweicloud.com/v3"
}