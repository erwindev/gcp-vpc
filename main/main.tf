provider "google" {
  credentials = file("../credentials.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "vpc" {
  source                 = "../modules/global" 
  project_id             = var.project_id  
  network_name           = var.network_name
  env                    = var.env
  company                = var.company
  ue1_public_subnet      = var.ue1_public_subnet
  ue1_application_subnet = var.ue1_application_subnet
  ue1_management_subnet  = var.ue1_management_subnet
}

module "ue1" {
  source                 = "../modules/ue1"
  network_self_link      = module.vpc.out_vpc_self_link
  env                    = var.env
  company                = var.company
  region                 = var.region
  zone                   = var.zone
  ue1_public_subnet      = var.ue1_public_subnet
  ue1_application_subnet = var.ue1_application_subnet
  ue1_management_subnet  = var.ue1_management_subnet  
  user                   = var.user
  ssh_key                = var.ssh_key
}