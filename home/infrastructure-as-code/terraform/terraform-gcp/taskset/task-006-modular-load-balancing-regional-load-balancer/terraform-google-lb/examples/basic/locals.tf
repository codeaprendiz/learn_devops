/*
The code above is an example of using Terraform's "locals" block to define a variable with a nested object.

The object defined in the "health_check" variable represents a health check configuration for a load balancer or other similar infrastructure component. Here's what each key-value pair means:

    - check_interval_sec: The number of seconds between each health check.
    - healthy_threshold: The number of consecutive successful health checks required to mark an instance as healthy.
    - timeout_sec: The number of seconds to wait for a response before considering the health check to have failed.
    - unhealthy_threshold: The number of consecutive failed health checks required to mark an instance as unhealthy.
    - port: The port number to use for the health check request.
    - request_path: The path to use for the health check request.
    - host: The IP address or domain name of the instance to perform the health check on.
By defining this configuration in a "locals" block, the values can be easily reused throughout the Terraform codebase without having to repeat the configuration details every time.
*/

locals {
  health_check = {
    check_interval_sec  = 1
    healthy_threshold   = 4
    timeout_sec         = 1
    unhealthy_threshold = 5
    port                = 8080
    request_path        = "/mypath"
    host                = "1.2.3.4"
  }
}
