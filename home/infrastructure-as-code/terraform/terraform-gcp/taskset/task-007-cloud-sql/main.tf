/*
This block specifies the Google Cloud Platform provider for Terraform with a version constraint.
This provider allows Terraform to interact with GCP resources like compute instances, storage buckets, and networking components
*/
provider "google" {
  version = "~> 2.13"
}

/*
The google-beta provider allows Terraform to interact with GCP beta resources that
are not yet available in the production version of the google provider.
*/
provider "google-beta" {
  version = "~> 2.13"
}

/*
This block specifies the Random provider with a version constraint of ~> 2.2
The random provider allows Terraform to generate random values during resource creation,
which can be useful for testing and creating unique resource names.
*/
provider "random" {
  version = "~> 2.2"
}

/*
This block defines a Terraform resource of type random_id with the name name.
This resource is used to generate a random identifier value that can be used in other resources or modules.
*/
resource "random_id" "name" {
  byte_length = 2
}

/*
The resource block declares a resource of type google_sql_database_instance with the name master.

The name, project, region, database_version, and master_instance_name arguments are set to the
values provided in the variables var.project, var.region, var.database_version, and var.master_instance_name.
*/
resource "google_sql_database_instance" "master" {
  name                 = "example-mysql-${random_id.name.hex}"
  project              = var.project
  region               = var.region
  database_version     = var.database_version
  master_instance_name = var.master_instance_name

  /*
  The settings block includes various configurations for the database instance,
  such as tier, activation_policy, disk_autoresize, backup_configuration,
  ip_configuration, location_preference, maintenance_window, disk_size, disk_type, pricing_plan,
  replication_type, and availability_type. The values for these configurations are provided in the variables.
  */
  settings {
    tier                        = var.tier
    activation_policy           = var.activation_policy
    disk_autoresize             = var.disk_autoresize


    dynamic "backup_configuration" {
      for_each = [var.backup_configuration]
      content {

        binary_log_enabled = lookup(backup_configuration.value, "binary_log_enabled", null)
        enabled            = lookup(backup_configuration.value, "enabled", null)
        start_time         = lookup(backup_configuration.value, "start_time", null)
      }
    }
    dynamic "ip_configuration" {
      for_each = [var.ip_configuration]
      content {

        ipv4_enabled    = lookup(ip_configuration.value, "ipv4_enabled", true)
        private_network = lookup(ip_configuration.value, "private_network", null)
        require_ssl     = lookup(ip_configuration.value, "require_ssl", null)

        dynamic "authorized_networks" {
          for_each = lookup(ip_configuration.value, "authorized_networks", [])
          content {
            expiration_time = lookup(authorized_networks.value, "expiration_time", null)
            name            = lookup(authorized_networks.value, "name", null)
            value           = lookup(authorized_networks.value, "value", null)
          }
        }
      }
    }
    dynamic "location_preference" {
      for_each = [var.location_preference]
      content {

        follow_gae_application = lookup(location_preference.value, "follow_gae_application", null)
        zone                   = lookup(location_preference.value, "zone", null)
      }
    }
    /*
      The dynamic blocks inside the settings block are used to handle configurations that
      can have multiple instances. For example, maintenance_window can have multiple instances
      of different configurations, so it is specified as a dynamic block.
    */
    dynamic "maintenance_window" {
      for_each = [var.maintenance_window]
      content {

        day          = lookup(maintenance_window.value, "day", null)
        hour         = lookup(maintenance_window.value, "hour", null)
        update_track = lookup(maintenance_window.value, "update_track", null)
      }
    }
    disk_size        = var.disk_size
    disk_type        = var.disk_type
    pricing_plan     = var.pricing_plan
    availability_type = var.availability_type
  }

  dynamic "replica_configuration" {
    for_each = [var.replica_configuration]
    content {

      ca_certificate            = lookup(replica_configuration.value, "ca_certificate", null)
      client_certificate        = lookup(replica_configuration.value, "client_certificate", null)
      client_key                = lookup(replica_configuration.value, "client_key", null)
      connect_retry_interval    = lookup(replica_configuration.value, "connect_retry_interval", null)
      dump_file_path            = lookup(replica_configuration.value, "dump_file_path", null)
      failover_target           = lookup(replica_configuration.value, "failover_target", null)
      master_heartbeat_period   = lookup(replica_configuration.value, "master_heartbeat_period", null)
      password                  = lookup(replica_configuration.value, "password", null)
      ssl_cipher                = lookup(replica_configuration.value, "ssl_cipher", null)
      username                  = lookup(replica_configuration.value, "username", null)
      verify_server_certificate = lookup(replica_configuration.value, "verify_server_certificate", null)
    }
  }

  /*
  The timeouts block specifies the maximum amount of time allowed for creating and deleting the instance.
  */
  timeouts {
    create = "60m"
    delete = "2h"
  }
}

/*
This is a Terraform resource block that creates a Google Cloud SQL database.

The count argument is used to conditionally create this resource.
If the var.master_instance_name variable is an empty string, then count is set to 1, which means this resource will be created.
Otherwise, if var.master_instance_name is not empty, count is set to 0, which means this resource will not be created.

The name argument specifies the name of the database to be created.

The project argument specifies the Google Cloud project in which to create the database.

The instance argument specifies the name of the Google Cloud SQL instance on which to create the database.
This value is obtained from the google_sql_database_instance.master.name attribute,
which refers to the name attribute of the google_sql_database_instance resource named master.

The charset and collation arguments are used to set the character set and collation for the database, respectively.
*/
resource "google_sql_database" "default" {
  count     = var.master_instance_name == "" ? 1 : 0
  name      = var.db_name
  project   = var.project
  instance  = google_sql_database_instance.master.name
  charset   = var.db_charset
  collation = var.db_collation
}

/*
This Terraform code declares a resource block of type random_id, which is used to generate a random identifier.
The identifier is then used to create a random password for a user, for example, in an authentication system.
*/
resource "random_id" "user-password" {
  byte_length = 8
}

/*
This is a Terraform configuration code that creates a SQL user in a Google Cloud SQL instance.
*/
resource "google_sql_user" "default" {
  // This line uses a conditional operator to set the count of the resource to 1 if the
  // master_instance_name variable is empty, or 0 if it is not.
  count    = var.master_instance_name == "" ? 1 : 0
  // This sets the name of the SQL user to the value of the user_name variable.
  name     = var.user_name
  project  = var.project
  //  This sets the name of the Google Cloud SQL instance where the user will be created.
  instance = google_sql_database_instance.master.name
  // This sets the host where the SQL user can connect from.
  host     = var.user_host
  // This sets the password for the SQL user. If the user_password variable is not set, a random password is generated using
  // the random_id resource.
  // Otherwise, the user_password variable value is used.
  password = var.user_password == "" ? random_id.user-password.hex : var.user_password
}


