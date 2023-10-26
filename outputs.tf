output "secrets_engine_name"{
  value = "Database Secrets Engine mounted at: ${var.path_name}"
}

 output "secrets_engine_role"{

   value = [
    for role in vault_database_secret_backend_role.roles : "DB role created: ${role.name}"
 ]
 }