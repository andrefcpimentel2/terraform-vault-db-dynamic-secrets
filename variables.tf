variable "db_type" {
    description = "Database type - can be cassandra. mysql or postgresql"
}

variable "path_name" {
    description = "Vault Secrets Engine path name"
}

variable "db_connection_host" {
    description = "DB connection host address only. The template will resolve connection schemes/user data"
}

variable "db_name" {
    description = "Vault Secrets Engine path name"
}

variable "db_username" {
    description = "Vault Secrets Engine path name"
}

variable "db_password" {
    description = "Vault Secrets Engine path name"
}

variable "roles" {
   description = "Vault roles according to db_type. You can add as many as you can in the statements block. The role name is the statement key"
  default = { 
     "cassandra" = {
        "db_type" = "cassandra"
        statements = {
        "dev" = "CREATE USER '{{username}}' WITH PASSWORD '{{password}}' NOSUPERUSER; GRANT SELECT ON ALL KEYSPACES TO {{username}};"
        "admin" = "CREATE USER '{{username}}' WITH PASSWORD '{{password}}' NOSUPERUSER; GRANT SELECT ON ALL KEYSPACES TO {{username}};"
        # and the rest
        }
      },
     "mysql" = {
        "db_type" = "mysql"
        statements = {
        "dev" = "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';"
        "admin" = "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';"
        # and the rest
        }
      },
     "postgresql" = {
        "db_type" = "postgresql"
        statements = {
        "dev" = "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
        "admin" = "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
        # and the rest
        }
      },
  }
}