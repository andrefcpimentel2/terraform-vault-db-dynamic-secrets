# terraform-vault-db-dynamic-secrets

This module configures DB secrets engines and roles suing the Vault provider.
You will configure one DB secrets engine (in one DB) per module run/state file.
You can call this module several times using a var map in another TF project, and even leverage Vault Namespaces, etc.

## How to use this module
You will need to have the Vault provider Environment Variables set (VAULT_ADDR, VAULT_TOKEN), the same in TFC env vars.

You will need the following information:

* db_type 
* db_connection_host
* db_name 
* db_username 
* db_password 
* path_name 

## Adding more Database types and roles

You can add more database types, adding dynamic blocks at the vault_database_secrets_mount resource.
For Vault Roles (and their SQL statements), you will need to add them at the roles variable map, and you can add as many roles as you want. Just remember to add them at the <b>allowed_roles</b> property in the dynamic blocks.

