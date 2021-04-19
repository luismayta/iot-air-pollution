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
  default = "team/luismayta/csr/iot-air-pollution-prod.private.key"
}

variable "public_key" {
  default = "team/luismayta/csr/iot-air-pollution-prod.public.key"
}

variable "file_crt" {
  default = "team/luismayta/csr/iot-air-pollution-prod.pem.crt"
}

variable "root_ca" {
  default = "team/luismayta/csr/iot-air-pollution-prod-root-certificate.pem.crt"
}

# AWS

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "user" {
  type        = map(string)
  description = "data user"
  default = {
    "ssh_user" = "ubuntu"
    "ssh_port" = 22
  }
}

variable "aws_keys" {
  type        = map(string)
  description = "keys pem and pub"
  default = {
    "pem" = "team/luismayta/pem/iot-air-pollution-prod.pem"
    "pub" = "team/luismayta/pub/iot-air-pollution-prod.pub"
  }
}
