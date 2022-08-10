module "notifications" {
  for_each           = local.notifications_map
  source             = "github.com/neuralnetes/monorepo.git//terraform/modules/google/cloud-storage-notification?ref=main"
  project_id         = each.value["project_id"]
  bucket_name        = each.value["bucket_name"]
  pubsub_topic_name  = each.value["pubsub_topic_name"]
  custom_attributes  = each.value["custom_attributes"]
  object_name_prefix = each.value["object_name_prefix"]
  event_types        = each.value["event_types"]
}

locals {
  notifications_map = {
    for notification in var.notifications :
    "${notification["bucket_name"]}/${notification["pubsub_topic_name"]}" => notification
  }
}