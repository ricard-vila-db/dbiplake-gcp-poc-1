# dbiplake-gcp-poc
DB IP Lake project PoC - GCP integration &amp; events

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.66.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.66.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.pubsub_agent](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_cloud_run_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_binding.binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_binding) | resource |
| [google_project_iam_binding.project_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_service.run_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_pubsub_subscription.cloudrun](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_binding.binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_binding) | resource |
| [google_service_account.pubsub_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.destination_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.source_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.tfsate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_notification.notification](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_notification) | resource |
| [random_id.bucket_prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_storage_project_service_account.gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CR_copy_service"></a> [CR\_copy\_service](#input\_CR\_copy\_service) | (Required) The name of CR service/container to copy files between source bucket and staging destination bucket | `string` | `"copy-btw-buckets"` | no |
| <a name="input_CR_location"></a> [CR\_location](#input\_CR\_location) | (Required) The location of the cloud run instance. eg europe-west3 | `string` | `"europe-west3"` | no |
| <a name="input_project"></a> [project](#input\_project) | (Required) The GCP project where run terraform | `string` | `"dbiplake-gft-poc-387706"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) The GCP region where run terraform | `string` | `"europe-west3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_run_id"></a> [cloud\_run\_id](#output\_cloud\_run\_id) | Cloud Run service Identifier |
| <a name="output_cloud_run_url"></a> [cloud\_run\_url](#output\_cloud\_run\_url) | Cloud Run service URL address |
<!-- END_TF_DOCS -->