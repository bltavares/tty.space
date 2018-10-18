terraform {
    backed "gcs" {
        bucket = "${TF_ADMIN}"
        prefix = "terraform/state"
        project = "${TF_ADMIN}"
    }
}