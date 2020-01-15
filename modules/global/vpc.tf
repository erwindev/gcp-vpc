resource "google_compute_network" "vpc" {
  name                    =  var.network_name
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
  project                 = var.project_id
}

resource "google_compute_firewall" "allow-internal" {
  name    = "${var.company}-${var.env}-fw-allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = [
    "${var.ue1_public_subnet}",
    "${var.ue1_management_subnet}",
    "${var.ue1_application_subnet}"
  ]
}

resource "google_compute_firewall" "allow-ssh-from-everywhere-to-bastion" {
  name    = "${var.company}-${var.env}-fw-allow-ssh-from-everywhere-to-bastion"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["bastion"]

}

resource "google_compute_firewall" "allow-ssh-from-bastion-to-webservers"{
  name      = "${var.company}-${var.env}-fw-allow-ssh-from-bastion-to-webservers"
  network   = google_compute_network.vpc.name
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]

}

resource "google_compute_firewall" "allow-ssh-to-webservers-from-bastion"{
  name      = "${var.company}-${var.env}-fw-allow-ssh-to-webservers-from-bastion"
  network   = google_compute_network.vpc.name
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]

}

resource "google_compute_firewall" "allow-http-to-webservers" {
  name    = "${var.company}-${var.env}-fw-allow-http-to-webservers"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags   = ["http"]
}

resource "google_compute_firewall" "allow-db-connect-from-applications" {
  name      = "${var.company}-${var.env}-fw-allow-db-connect-from-applications"
  network   = google_compute_network.vpc.name
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = ["3306", "5432", "1433"]
  }

  destination_ranges = ["0.0.0.0/0"]

  target_tags = ["db"]

}


