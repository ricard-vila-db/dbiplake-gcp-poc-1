variable "project" {
  description = "(Required) The GCP project where run terraform"
  type        = string
  default     = "dbiplake-gft-poc"
}
variable "region" {
  description = "(Required) The GCP region where run terraform"
  type        = string
  default     = "europe-west3"
}
variable "CR_location" {
  description = "(Required) The location of the cloud run instance. eg europe-west3"
  type        = string
  default     = "europe-west3"
}
variable "CR_copy_service" {
  description = "(Required) The name of CR service/container to copy files between source bucket and staging destination bucket"
  type        = string
  default     = "copy-btw-buckets"
}