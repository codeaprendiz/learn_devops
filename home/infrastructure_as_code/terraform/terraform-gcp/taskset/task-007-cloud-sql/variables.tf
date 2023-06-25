variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable "region" {
  description = "Region for cloud resources"
  default     = "us-central1"
}

variable "database_version" {
  description = "The version of of the database. For example, `MYSQL_5_6` or `POSTGRES_9_6`."
  default     = "MYSQL_5_6"
}

variable "master_instance_name" {
  description = "The name of the master instance to replicate"
  default     = ""
}

variable "tier" {
  description = "The machine tier (First Generation) or type (Second Generation). See this page for supported tiers and pricing: https://cloud.google.com/sql/pricing"
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "Name of the default database to create"
  default     = "default"
}

variable "db_charset" {
  description = "The charset for the default database"
  default     = ""
}

variable "db_collation" {
  description = "The collation for the default database. Example for MySQL databases: 'utf8_general_ci', and Postgres: 'en_US.UTF8'"
  default     = ""
}

variable "user_name" {
  description = "The name of the default user"
  default     = "default"
}

variable "user_host" {
  description = "The host for the default user"
  default     = "%"
}

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  default     = ""
}

variable "activation_policy" {
  description = "This specifies when the instance should be active. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  default     = "ALWAYS"
}

variable "authorized_gae_applications" {
  description = "A list of Google App Engine (GAE) project names that are allowed to access this instance."
  default     = []
}

variable "disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically."
  default     = true
}

variable "disk_size" {
  description = "Second generation only. The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  default     = 10
}

variable "disk_type" {
  description = "Second generation only. The type of data disk: `PD_SSD` or `PD_HDD`."
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "First generation only. Pricing plan for this instance, can be one of `PER_USE` or `PACKAGE`."
  default     = "PER_USE"
}

variable "replication_type" {
  description = "Replication type for this instance, can be one of `ASYNCHRONOUS` or `SYNCHRONOUS`."
  default     = "SYNCHRONOUS"
}

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server"
  default     = []
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  default     = {}
}

variable "ip_configuration" {
  description = "The ip_configuration settings subblock"
  default     = {}
}

variable "location_preference" {
  description = "The location_preference settings subblock"
  default     = {}
}

/*
In this example, the maintenance_window variable is a list of two subblocks, each containing day, hour, and update_track settings
for the database instance's maintenance window. This allows you to specify multiple maintenance windows with different settings.

variable "maintenance_window" {
  description = "The maintenance_window settings subblock"
  default     = [
    {
      day          = "SAT"
      hour         = 4
      update_track = "canary"
    },
    {
      day          = "SUN"
      hour         = 2
      update_track = "stable"
    }
  ]
}

*/

variable "maintenance_window" {
  description = "The maintenance_window settings subblock"
  default     = {}
}



variable "replica_configuration" {
  description = "The optional replica_configuration block for the database instance"
  default     = {}
}

variable "availability_type" {
  description = "This specifies whether a PostgreSQL instance should be set up for high availability (REGIONAL) or single zone (ZONAL)."
  default     = "ZONAL"
}


