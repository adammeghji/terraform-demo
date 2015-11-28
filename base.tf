variable "access_key" {}
variable "secret_key" {}
variable "region"     {
	default = "us-west-2"
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

variable "aws_zone_id" {
  default = "ZT0C35LV57KL2"
}

variable "hostname" {
  default = "tfdemo.universe.com"
}

