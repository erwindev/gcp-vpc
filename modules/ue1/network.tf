resource "google_compute_subnetwork" "management_subnet" {
  name          = "${var.company}-${var.env}-ue1-management"
  ip_cidr_range = var.ue1_management_subnet
  network       = var.network_self_link
  region        = var.region
}
resource "google_compute_subnetwork" "application_subnet" {
  name          = "${var.company}-${var.env}-ue1-application"
  ip_cidr_range = var.ue1_application_subnet
  network       = var.network_self_link
  region        = var.region
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.company}-${var.env}-ue1-public"
  ip_cidr_range = var.ue1_public_subnet
  network       = var.network_self_link
  region        = var.region
}