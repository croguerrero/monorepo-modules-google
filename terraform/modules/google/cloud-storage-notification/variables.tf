variable "project_id" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "pubsub_topic_name" {
  type = string
}
variable "custom_attributes" {
  type = map(string)
}
variable "object_name_prefix" {
  type = string
}
variable "event_types" {
  type = list(string)
}