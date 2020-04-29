variable "vpc_id" {}
variable "network_id" {}

variable "keypair_name" {}

variable "ecs_flavor" {
  default = "s3.medium.2"
}