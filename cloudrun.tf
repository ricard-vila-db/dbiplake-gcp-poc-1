#resource "google_project_service" "registry_api" {
#  service = "artifactregistry.googleapis.com"
#}
#
#resource "google_artifact_registry_repository" "docker-repo" {
#  location      = var.region
#  repository_id = "docker-repo"
#  description   = "docker repository for images to run in Cloud Run"
#  format        = "DOCKER"
#
#  docker_config {
#    immutable_tags = true
#  }
#  labels = {
#    dont-delete = "till-31-12-2023"
#    owner       = "rdgi"
#  }
#  # Use an explicit depends_on clause to wait until API is enabled
#  depends_on = [
#    google_project_service.registry_api
#  ]
#}

#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service
# Cloud Run Service Basic:
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"
}
resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = var.CR_location

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        #image = "gcr.io/${var.project}/${var.CR_copy_service}"
        #image = "europe-west3-docker.pkg.dev/dbiplake-gft-poc/docker-repo/<image>"
      }
      #service_account_name = google_service_account.cloudrun.email
    }
    metadata {
      labels = {
        dont-delete = "till-31-12-2023"
        owner       = "rdgi"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Use an explicit depends_on clause to wait until API is enabled
  depends_on = [
    google_project_service.run_api
  ]
}

# Cloud Scheduler
# Create a service account to associate with Cloud Scheduler, and give that service account the permission to invoke your Cloud Run service
#resource "google_project_service" "iam_api" {
#  service = "iam.googleapis.com"
#}
#resource "google_service_account" "cloudrun" {
#  account_id   = "scheduler-sa"
#  description  = "Cloud Scheduler service account; used to trigger scheduled Cloud Run jobs."
#  display_name = "scheduler-sa"
#
#  # Use an explicit depends_on clause to wait until API is enabled
#  depends_on = [
#    google_project_service.iam_api
#  ]
#}
##Give the invoker service account permission to invoke your default cloudrun service
#resource "google_cloud_run_service_iam_binding" "binding" {
#  location = google_cloud_run_service.default.location
#  service  = google_cloud_run_service.default.name
#  role     = "roles/run.invoker"
#  members  = ["serviceAccount:${google_service_account.cloudrun.email}"]
#}
#
##Create a job that invokes your service at specified times
#resource "google_project_service" "scheduler_api" {
#  service = "cloudscheduler.googleapis.com"
#}
#
#resource "google_cloud_scheduler_job" "default" {
#  name             = "scheduled-cloud-run-job"
#  description      = "Invoke a Cloud Run container on a schedule."
#  schedule         = "*/8 * * * *" # https://cloud.google.com/scheduler/docs/configuring/cron-job-schedules
#  time_zone        = "Europe/Berlin"
#  attempt_deadline = "320s"
#
#  retry_config {
#    retry_count = 1
#  }
#
#  http_target {
#    http_method = "POST"
#    uri         = google_cloud_run_service.default.status[0].url
#
#    oidc_token {
#      service_account_email = google_service_account.cloudrun.email
#    }
#  }
#
#  # Use an explicit depends_on clause to wait until API is enabled
#  depends_on = [
#    google_project_service.scheduler_api
#  ]
#}