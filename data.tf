data "google_project" "project" {
}

# Enable notifications by giving the correct IAM permission to the unique service account.
data "google_storage_project_service_account" "gcs_account" {
  #provider = google-beta
  project  = var.project
}
