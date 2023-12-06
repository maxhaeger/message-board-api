terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.10.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16" #
    }
  }
  backend "s3" {
    bucket = "linode-lke-cluster-terraform-state"
    key    = "prod/message-board-api/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "linode-lke-cluster-lock"
    encrypt        = true
  }
}

provider "linode" {
  token = var.linode_token
}

resource "linode_lke_cluster" "message-board-cluster" {
  label       = "message-board-lke"
  k8s_version = "1.27"
  region      = "eu-central"
  tags        = ["prod"]

  pool {
    type  = "g6-standard-1"
    count = 1
  }

}

