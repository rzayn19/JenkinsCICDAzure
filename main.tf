provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rd" {
  name     = "Prodrd"
  location = "eastus"
}

resource "azurerm_virtual_network" "vpc" {
  name                = "Prodrdvpc"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rd.name
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.rd.name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a storage account for the virtual machine disks
resource "azurerm_storage_account" "rd" {
  name                     = "Prodrdsa"
  resource_group_name      = azurerm_resource_group.rd.name
  location                 = azurerm_resource_group.rd.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
# Create an Azure SQL Virtual Machine
resource "azurerm_sql_virtual_machine" "rd" {
  name                = "ProdrdSQLVM"
  location            = azurerm_resource_group.rd.location
  resource_group_name = azurerm_resource_group.rd.name
  subnet_id           = azurerm_subnet.rd.id
  sql_server_id       = azurerm_sql_server.rd.id
  admin_username      = "rdadmin"
  admin_password      = "Tech@123"
  
# Specify the virtual machine configuration
  vm_size     = "Standard_B2ms"
  offer       = "sql2022-ws2022"
  publisher   = "MicrosoftSQLServer"
  sku         = "sqldev-gen2"
  version     = "latest"
  license_type = "PAYG"
  

  storage_os_disk {
    name              = "rd-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
