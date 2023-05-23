data "google_project" "project" {
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

#resource "google_storage_bucket" "default" {
#  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
#  force_destroy = false
#  location      = "EU"
#  storage_class = "STANDARD"
#  versioning {
#    enabled = true
#  }
#  uniform_bucket_level_access = true
#  labels = {
#    dont-delete = "till-31-12-2023"
#    owner       = "rdgi"
#  }
#}