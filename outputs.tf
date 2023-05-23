output "cloud_run_id" {
  value       = google_cloud_run_service.default.id
  description = "Cloud Run service Identifier"
}

output "cloud_run_url" {
  value       = google_cloud_run_service.default.status[0].url
  description = "Cloud Run service URL address"
}