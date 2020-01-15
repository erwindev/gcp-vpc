resource "google_compute_instance" "webserver_instance_1" {
  name         = "${var.company}-${var.env}-webserver-instance1"
  machine_type  = "g1-small"
  zone          =  var.zone
  tags          = ["http"]

  metadata = {
    ssh-keys = "${var.user}:${file("${var.ssh_key}")}"
  }

  boot_disk {
    initialize_params {
      image     =  "debian-cloud/debian-9"     
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq nginx; sudo service nginx restart"
 
  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.name
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  labels = {
    environment = "${var.env}"
  }
}

resource "google_compute_instance" "application_instance_1" {
  name         = "${var.company}-${var.env}-application-instance1"
  machine_type  = "g1-small"
  zone          =  var.zone

  metadata = {
    ssh-keys = "${var.user}:${file("${var.ssh_key}")}"
  }

  boot_disk {
    initialize_params {
      image     =  "debian-cloud/debian-9"     
    }
  }

  metadata_startup_script = "sudo apt-get update"
 
  network_interface {
    subnetwork = google_compute_subnetwork.application_subnet.name
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  labels = {
    environment = "${var.env}"
  }  
}


#####
#
# Bastion server running in the public cloud
#
#####

resource "google_compute_instance" "bastion" {
  name         = "${var.company}-${var.env}-bastion"
  machine_type  = "g1-small"
  zone          =  var.zone
  tags          = ["bastion"]

  metadata = {
    ssh-keys = "${var.user}:${file("${var.ssh_key}")}"
  }

  boot_disk {
    initialize_params {
      image     =  "debian-cloud/debian-9"     
    }
  }

  metadata_startup_script = "sudo apt-get update"

  network_interface {
    subnetwork = google_compute_subnetwork.management_subnet.name  
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}
