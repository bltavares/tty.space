data "google_compute_zones" "available" {}

resource "google_compute_instance" "default" {
  project      = "${google_project_services.project.project}"
  zone         = "${data.google_compute_zones.available.names[0]}"
  name         = "tf-compute-1"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "family/debian-9"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }
}

output "instance_id" {
  value = "${google_compute_instance.default.self_link}"
}

output "server_ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
