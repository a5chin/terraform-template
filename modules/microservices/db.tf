resource "google_sql_database_instance" "main" {
  name             = var.db.instance_name
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main.self_link
      ssl_mode        = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "main" {
  name      = var.db.database_name
  instance  = google_sql_database_instance.main.name
  charset   = var.db.charset
  collation = var.db.collation
}

resource "google_sql_user" "main" {
  name     = var.backend.env.DB_USER
  instance = google_sql_database_instance.main.name
  password = var.backend.env.DB_PWD
}
