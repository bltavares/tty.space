provider "google" {
  region  = "${var.region}"
  version = "~> 1.19"
}

provider "random" {
  version = "~> 2.0"
}
