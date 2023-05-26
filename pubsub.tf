# Create a Pub/Sub Topic
resource "google_pubsub_topic" "topic" {
  name = "cloud_run_topic"
  #provider = google-beta
  project = var.project
}
resource "google_pubsub_topic_iam_binding" "binding" {
  #provider = google-beta
  topic   = google_pubsub_topic.topic.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

# Create a Pub/Sub notification.
resource "google_storage_notification" "notification" {
  #provider       = google-beta
  bucket         = google_storage_bucket.destination_bucket.name
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.topic.id
  depends_on     = [google_pubsub_topic_iam_binding.binding]
}


// Updates the Bucket IAM policy to grant a role to a list of members. Other roles within the IAM policy for the bucket are preserved
#resource "google_storage_bucket_iam_binding" "binding" {
#  bucket = google_storage_bucket.destination_bucket.name
#  role = "roles/pubsub.editor"
#  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
#}


#Ref: https://cloud.google.com/run/docs/tutorials/pubsub#integrating-pubsub

#Create a Pub/Sub subscription with the service account:
resource "google_pubsub_subscription" "cloudrun" {
  name  = "pubsub_subscription"
  topic = google_pubsub_topic.topic.name
  #pull as default, if push is neeeded add the following:
  push_config {
    push_endpoint = google_cloud_run_service.default.status[0].url
    oidc_token {
      service_account_email = google_service_account.pubsub_subscription.email
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
  depends_on = [google_cloud_run_service.default]
}


#Create or select a service account to represent the Pub/Sub subscription identity.
resource "google_service_account" "pubsub_subscription" {
  account_id   = "cloud-run-pubsub-invoker"
  display_name = "Cloud Run Pub/Sub Invoker"
}
#Give the invoker service account permission to invoke your default cloudrun service
resource "google_cloud_run_service_iam_binding" "binding" {
  location   = google_cloud_run_service.default.location
  service    = google_cloud_run_service.default.name
  role       = "roles/run.invoker"
  members    = ["serviceAccount:${google_service_account.pubsub_subscription.email}"]
  depends_on = [google_service_account.pubsub_subscription]
}
#Allow Pub/Sub to create authentication tokens in your project
#The provider hashicorp/google does not support resource type "google_project_service_identity".
resource "google_project_service_identity" "pubsub_agent" {
  provider = google-beta
  project  = data.google_project.project.project_id
  service  = "pubsub.googleapis.com"
}
resource "google_project_iam_binding" "project_token_creator" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_project_service_identity.pubsub_agent.email}"]
}

