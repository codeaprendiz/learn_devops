// This output value represents the name of the database instance created by the Terraform configuration.
output "instance_name" {
  description = "The name of the database instance"
  value       = google_sql_database_instance.master.name
}

// This output value represents the IPv4 address of the master database instance created by the Terraform configuration.
output "instance_address" {
  description = "The IPv4 address of the master database instnace"
  value       = google_sql_database_instance.master.ip_address.0.ip_address
}

// This output value represents the time when the IPv4 address of the master database instance created
// by the Terraform configuration will be retired.
output "instance_address_time_to_retire" {
  description = "The time the master instance IP address will be retired. RFC 3339 format."
  value       = google_sql_database_instance.master.ip_address.0.time_to_retire
}

/*
This Terraform output block is defining an output named "self_link".
The output provides the self link to the Google Cloud SQL master instance created
using the resource "google_sql_database_instance".

The "self_link" attribute in Google Cloud SQL is a unique identifier for a resource,
and it is used to retrieve, update or delete the resource. The value of the "self_link"
output is set to the value of the "self_link" attribute of the "google_sql_database_instance"
resource created in the Terraform code.

Once this Terraform code is executed, the "self_link" output value can be
retrieved using the Terraform CLI command terraform output self_link.
*/
output "self_link" {
  description = "Self link to the master instance"
  value       = google_sql_database_instance.master.self_link
}

// This output value represents the auto-generated default user password if no input password was provided.
// This value is marked as sensitive to ensure that it is not accidentally exposed.
output "generated_user_password" {
  description = "The auto generated default user password if no input password was provided"
  value       = random_id.user-password.hex
  sensitive   = true
}


