resource "google_sql_database_instance" "this" {
  name             = var.db.instance_name
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.this.self_link
      ssl_mode        = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "this" {
  name      = var.db.database_name
  instance  = google_sql_database_instance.this.name
  charset   = var.db.charset
  collation = var.db.collation
}

resource "google_sql_user" "this" {
  name     = var.backend.env.DB_USER
  instance = google_sql_database_instance.this.name
  password = var.backend.env.DB_PWD
}
