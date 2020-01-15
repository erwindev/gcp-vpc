variable "project_id" {
    default = "erwin-gpc-environment"
}
variable "region" {
    default = "us-east1"
}
variable "zone" {
    default = "us-east1-b"
}
variable "network_name" {
    default = "erwindev-vpc"
}
variable "env" {
    default = "dev"
}
variable "company" { 
    default = "erwindev"
}
variable "ue1_public_subnet" {
    default = "10.26.1.0/24"
}
variable "ue1_management_subnet" {
    default = "10.26.2.0/24"
}
variable "ue1_application_subnet" {
    default = "10.26.3.0/24"
}
variable "user"{
    default = "ealberto"
}
variable "ssh_key"{
    default = "../dev_key.pub"
}
