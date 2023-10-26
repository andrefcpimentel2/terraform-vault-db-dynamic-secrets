# terraform-vault-db-dynamic-secrets

This module configures Vault DB secrets engines and roles using the Vault TF provider.
It will configure only one DB secrets engine (in one DB) per module run/state file.
You can call this module several times using a var map in another TF project, and even leverage Vault Namespaces, etc.

## How to use this module
You will need to have the Vault provider Environment Variables set (VAULT_ADDR, VAULT_TOKEN), and also use environment vars on TFC.

You will need the following information:

* db_type 
* db_connection_host
* db_name 
* db_username 
* db_password 
* path_name 

There should be connectivity from your Vault instance to the Database.

## Adding more Database types and roles

You can add more database types, just by adding dynamic blocks at the vault_database_secrets_mount resource.
For Vault Roles (and their SQL statements), you will need to add them at the roles variable map, and you can add as many roles as you want. The statement key will be the role name, and the value, the statement itself. Just remember to add them also at the <b>allowed_roles</b> property in the dynamic blocks.

