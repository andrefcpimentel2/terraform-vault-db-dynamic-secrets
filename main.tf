#dynamic block on this resource -> to add more DB types, add another block, and another object on the roles list
resource "vault_database_secrets_mount" "db" {
  path = var.path_name

  dynamic "cassandra" {
    for_each = var.db_type == "cassandra" ? [1] : []
    content {
        name           = var.db_name
        username       = var.db_username
        password       = var.db_password
        hosts = "${var.db_connection_host}"
        allowed_roles = ["dev", "admin"]
    }
  }
  
  dynamic "mysql" {
    for_each = var.db_type == "mysql" ? [1] : []
    content {
        name           = var.db_name
        username       = var.db_username
        password       = var.db_password
        connection_url = "{{username}}:{{password}}@tcp(${var.db_connection_host})/mysql"
        allowed_roles = ["dev", "admin"]
    }
  }

  dynamic "postgresql" {
    for_each = var.db_type == "postgresql" ? [1] : []
    content {
        name              = var.db_name
        username          = var.db_username
        password          = var.db_password
        connection_url    = "postgresql://{{username}}:{{password}}@${var.db_connection_host}/postgres"
        verify_connection = true
        allowed_roles = ["dev", "admin"]
    }
  }
}

#Flatten the statement list according to the DB we are using
locals {
statement_list = flatten([for db_type, role_statement in var.roles :
 role_statement.statements if db_type == var.db_type
])
}

#Tip: testing the right output for the statement list -> uncomment this and do a tf plan
# output "myout" {
#   value = {for k, st in local.statement_list[0] : k =>st}
# }

#Role resources. Using loops here to create as many roles as we want, according to the roles var.
resource "vault_database_secret_backend_role" "roles" {
  for_each = {
    for key, value in local.statement_list[0] : key => value
  }
  name    = each.key
  backend = vault_database_secrets_mount.db.path
  db_name = var.db_name
  creation_statements = [each.value]
}