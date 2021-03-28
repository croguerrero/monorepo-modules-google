variable "container_clusters" {
  type = list(object({
    add_cluster_firewall_rules = bool
    autoscaling                = bool
    create_service_account     = bool
    enable_private_nodes       = bool
    firewall_inbound_ports     = list(string)
    http_load_balancing        = bool
    ip_range_pods              = string
    ip_range_services          = string
    master_authorized_networks = list(object({
      cidr_block   = string,
      display_name = string
    }))
    master_ipv4_cidr_block   = string
    name                     = string
    network                  = string
    network_project_id       = string
    node_pools               = list(map(string))
    node_pools_tags          = map(list(string))
    project_id               = string
    region                   = string
    regional                 = bool
    remove_default_node_pool = bool
    service_account          = string
    subnetwork               = string
    zones                    = list(string)
  }))
}