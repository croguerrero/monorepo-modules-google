variable "service_accounts" {
  type = list(object({
    project_id    = string
    account_id = string
  }))
}

variable "service_account_datas" {
  type = list(object({
    project_id    = string
    account_id = string
  }))
}