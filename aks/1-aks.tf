resource "azurerm_kubernetes_cluster" "aks" {
  depends_on = [var.vnet]
  name                = "akscluster"
  dns_prefix          = "akscluster"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  kubernetes_version  = "1.28.3"
  automatic_channel_upgrade = "stable"
  http_application_routing_enabled = true 
  sku_tier = "Standard"
  node_resource_group = "node-rs"
    
  storage_profile {
    blob_driver_enabled = true
    disk_driver_enabled = true
    file_driver_enabled = true
    snapshot_controller_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_plugin_mode = "Overlay"
    ebpf_data_plane = "cilium"
    pod_cidr = "192.168.0.0/16"
    service_cidr = "10.0.4.0/24"
    dns_service_ip = "10.0.4.10"
    load_balancer_sku  = "standard"
  }

  default_node_pool {
    name                = "aksclusys"
    min_count           = 2
    max_count           = 2
    vnet_subnet_id = var.address_subnet_nat
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
  }    
  identity {
    type = "SystemAssigned"
  }

  
}
