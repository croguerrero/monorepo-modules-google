variable "notifications" {
  type = list(object({
    project_id        = string
    bucket_name       = string
    pubsub_topic_name = string
    custom_attributes = map(string)
    object_name_prefix = string
    event_types = list(string)
  }))
}
