terraform {
  backend "gcs" {
    bucket  = "ttyspace-terraform-admin"
    prefix  = "terraform/state"
    project = "ttyspace-terraform-admin"
  }
}

module "gcp" {
  source = "./modules/gcp"

  project_name    = "${var.project_name}"
  billing_account = "${var.billing_account}"
  org_id          = "${var.org_id}"
  region          = "${var.region}"
}

module "cloudflare" {
  source = "./modules/cloudflare"

  token                     = "${var.cloudflare_token}"
  email                     = "${var.cloudflare_email}"
  google_authentication_txt = "${var.google_authentication_txt}"
  server_ip                 = "${module.gcp.server_ip}"
}
