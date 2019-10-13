variable "namespace" {
  type = string
}

variable "keybase_path" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "project" {
  default = "air-pollution"
}

variable "stage" {
  default = "prod"
}

variable "key_name" {
  default = "iot-air-pollution"
}

variable "topic" {
  default = "air-pollution"
}

variable "private_key" {
  default = "team/ulima/csr/terraform-iot-air-pollution-prod.private.key"
}

variable "public_key" {
  default = "team/ulima/csr/terraform-iot-air-pollution-prod.public.key"
}

variable "file_crt" {
  default = "team/ulima/csr/terraform-iot-air-pollution-prod.pem.crt"
}

variable "root_ca" {
  default = "team/ulima/csr/terraform-iot-air-pollution-prod-root-certificate.pem.crt"
}

# AWS

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "user" {
  type        = "map"
  description = "data user"
  default = {
    "ssh_user" = "ubuntu"
    "ssh_port" = 22
  }
}

variable "aws_keys" {
  type        = "map"
  description = "keys pem and pub"
  default = {
    "pem" = "team/ulima/pem/terraform-iot-air-pollution-prod.pem"
    "pub" = "team/ulima/pub/terraform-iot-air-pollution-prod.pub"
  }
}
