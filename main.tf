terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "swap_space_filling_up" {
  source    = "./modules/swap_space_filling_up"

  providers = {
    shoreline = shoreline
  }
}