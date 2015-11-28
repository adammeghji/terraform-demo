# Terraform Demo

A simple demonstration of how Terraform can automate AWS infrastructre.

This demo will:
 - provision 5 EC2 instances running nginx
 - provision 1 ELB load balancer
 - configure DNS @ "tfdemo.universe.com"

Slides to accompany the demo @ http://slides.com/adammeghji/universe-terraform#/

## AWS account

1. Create an AWS account (http://aws.amazon.com/) if you don't have one already.
1. Create a keypair named "tfdemo" in
[us-west-2 region](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#KeyPairs:sort=keyName).
1. Download and store the tfdemo.pem file in ~/.ssh/tfdemo.pem.
1. `chmod 400 ~/.ssh/tfdemo.pem` (the demo SSHs into boxes with this key; the connection times out if you don't set perms).


## Installation

This assumes that you're using Homebrew to install packages.

1. `brew update`
1. `brew install terraform` (verify per instructions at https://terraform.io/intro/getting-started/install.html)
1. `brew install awscli` to install AWS CLI in OS X
1. `aws configure` to configure AWS API keys

## Usage

1. `make plan` to prepare Terraform changes
1. `make apply` to execute planned Terraform changes

## Uninstallation

1. `make plan_destroy` to prepare Terraform stack deletion
1. `make apply` to execute planned Terraform changes

## Caveats

1. Route53 DNS Zones are not currently configured in Terraform.  Presently, the "universe.com" zone is hard-coded into the demo.

## TODO

1. Make various properties as default variables (image_id, zone_id, etc.)
1. Use Terraform to provision Route53 zones, then associate to this dynamic zone in the "tfdemo" DNS resource


