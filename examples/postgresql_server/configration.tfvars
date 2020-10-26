resource_groups = {
  postgresql_region1 = {
    name   = "postgresql-rg1"
    region = "region1"
  }
  security_region1 = {
    name = "postgre-sql-security-rg1"
  }
}

postgresql_servers = {
  sales-rg1 = {
    name                          = "sales-rg1"
    region                        = "region1"
    resource_group_key            = "postgresql_region1"
    version                       = "9.6"
    sku_name                      = "GP_Gen5_8"
    administrator_login           = "postgresqlsalesadmin"
    keyvault_key                  = "postgresql-rg1"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = true
    

    postgresql_firewall_rules = {
      postgresql-firewall-rules = {
        name = "postgresql_server_firewallrule"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-rg1"
        start_ip_address    = "40.112.8.12"
        end_ip_address      = "40.112.8.12"
      }
    }

     postgresql_configuration = {
      postgresql_configuration = {
        name = "postgresql_server_configuration"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-rg1"
        value = "on"
      }
    }

    postgresql_database = {
      postgresql_database = {
        name = "postgresql_server_sampledb"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-rg1"
        charset             = "UTF8"
        collation           = "English_United States.1252"
      }
    }

    auto_grow_enabled = true

    azuread_administrator = {
      azuread_group_key = "sales_admins"
    }
    
    tags = {
      segment = "sales"
    }

     # Optional
    # threat_detection_policy = {
    #   enabled = true
    #   disabled_alerts = [
    #     # "Sql_Injection",
    #     # "Sql_Injection_Vulnerability",
    #     # "Access_Anomaly",
    #     # "Data_Exfiltration",
    #     # "Unsafe_Action"
    #   ]
    #   email_account_admins = false
    #   email_addresses           = []
    #   retention_days            = 15
    # }
    
  }

}

storage_accounts = {
  auditing-rg1 = {
    name                     = "auditingrg1"
    resource_group_key       = "postgresql_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
  security-rg1 = {
    name                     = "securityrg1"
    resource_group_key       = "security_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
}

keyvaults = {
  postgresql-rg1 = {
    name               = "postgresqlrg1"
    resource_group_key = "security_region1"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  postgresql-rg1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
  }
}

azuread_groups = {
  sales_admins = {
    name        = "sql-sales-admins"
    description = "Administrators of the sales SQL server."
    members = {
      user_principal_names = []
      object_ids = [
      ]
      group_keys             = []
      service_principal_keys = []
    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = []
      object_ids             = []
    }
    prevent_duplicate_name = false
  }
}
