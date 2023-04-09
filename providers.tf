# State Backend
terraform {
  backend "azurerm" {
    resource_group_name   = "NetworkWatcherRG"
    storage_account_name  = "testps7827"
    container_name        = "test"
    key                   = "NbFSAtByvmV8LiDL2qW5gfxben3uDcp44xQ8LB6tVsZRlXc7paAQH32oj/2smLysW3sAvC6Z9SZv+AStagu39A=="
  }
}
