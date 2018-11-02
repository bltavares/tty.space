provider "cloudflare" {
  version = "~> 1.7"
  email   = "${var.email}"
  token   = "${var.token}"
}

resource "cloudflare_record" "main" {
  name    = "tty.space"
  domain  = "tty.space"
  value   = "${var.server_ip}"
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "google_authentication" {
  name   = "tty.space"
  value  = "${var.google_authentication_txt}"
  type   = "TXT"
  domain = "tty.space"
}
