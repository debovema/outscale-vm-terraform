terraform {
  required_providers {
    outscale = {
      source  = "outscale/outscale"
      version = "~> 0.10"
    }
  }
  required_version = ">= 1.0.0"
}

provider "outscale" {
}
