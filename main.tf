terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}

# data "template_file" "user_data" {
#   template = file("scripts/test.yaml")
# }

resource "aws_instance" "Terraform_machine" {
  # ami           = "ami-06489866022e12a14" # Amazon linux
  ami           = "ami-03d3eec31be6ef6f9" # Ubuntu
  instance_type = "t2.micro"
  key_name = "Ankit"
  security_groups = ["lab_test_Ankit4"]

    tags = {
      Name = "Terraform_machine"
      X-Contact = "ankit.soni@progress.com"
      X-TTL = "30"
      X-Dept = "PS"
    }


  provisioner "file" {
    source      = "/Users/anksoni/Documents/Practise/SetupModule-Terraform/healthcheck.sh"
    destination = "/tmp/healthcheck.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/healthcheck.sh",
      "sudo /tmp/healthcheck.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("/Users/anksoni/Documents/Docs/SecurityPass/AWSKeys/Ankit.pem")
    host        = self.public_ip
  }
}