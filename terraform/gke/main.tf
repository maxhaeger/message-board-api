terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16" #
    }
    google = {
      source  = "hashicorp/google"
      version = "~>3.0"
    }

  }
  backend "s3" {
    bucket = "gke-cluster-terraform-state"
    key    = "prod/message-board-api/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "gke-cluster-lock"
    encrypt        = true
  }
}
provider "google" {
  credentials = file("message-board-api-408908-8cfd35fd79b0.json")
  project     = "message-board-api-408908"
  region      = "eu-central1"
}


resource "google_compute_network" "vpc_network" {
  project                 = "message-board-api-408908"
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  network  = google_compute_network.vpc_network.self_link
  location = "europe-west3-a"
  node_pool {
    name               = "default-pool"
    initial_node_count = 1

    node_config {
      preemptible  = true
      machine_type = "e2-small"
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }
  master_auth {

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}
