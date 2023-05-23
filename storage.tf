# Create a source storage bucket to emulate dbExchange mock server
resource "google_storage_bucket" "source_bucket" {
  name                        = "${random_id.bucket_prefix.hex}-source-bucket"
  project                     = var.project
  location                    = "US"
  uniform_bucket_level_access = true
  labels = {
    dont-delete = "till-31-12-2023"
    owner       = "rdgi"
  }
}

# Create a staging storage bucket to store files copied from storage bucket
resource "google_storage_bucket" "destination_bucket" {
  name                        = "${random_id.bucket_prefix.hex}-destination-bucket"
  project                     = var.project
  location                    = "US"
  uniform_bucket_level_access = true
  labels = {
    dont-delete = "till-31-12-2023"
    owner       = "rdgi"
  }
}
