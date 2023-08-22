terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

variable "cloud-ops-project" {
  type = string
}

provider "google" {
    project = var.cloud-ops-project
}

resource "google_compute_network" "default" {
  name                    = "default"
  auto_create_subnetworks = true
}

resource "google_project_organization_policy" "oslogin_policy" {
  project    = var.cloud-ops-project 
  constraint = "compute.requireOsLogin"

  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "shieldedvm_policy" {
  project    = var.cloud-ops-project 
  constraint = "compute.requireShieldedVm"

  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "externalip_policy" {
  project    = var.cloud-ops-project 
  constraint = "compute.vmExternalIpAccess"

  list_policy {
    allow {
      all = true
    }
  }
}

resource "google_project_organization_policy" "ipforward_policy" {
  project    = var.cloud-ops-project 
  constraint = "compute.vmCanIpForward"

  list_policy {
    allow {
      all = true
    }
  }
}
