variable "path" {
  description = "a kustomize directory, it must contain a kustomization.yaml file."
  type        = string
}

variable "kubeconfig_raw" {
  type = string
}