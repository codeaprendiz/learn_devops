/*
  This block of code defines a Terraform data source of type "template_file" named "instance_startup_script".
  The data source reads the contents of a file named "gceme.sh.tpl" located in the module directory using the file() 
  function.
  It also defines a variable named "PROXY_PATH" with an empty string as its value to be used in the template.
*/
data "template_file" "instance_startup_script" {
  template = file("${path.module}/templates/gceme.sh.tpl")

  vars = {
    PROXY_PATH = ""
  }
}


/*
  This block of code defines a Google Cloud Platform service account resource named
  "google_service_account.instance-group".
  The resource sets the account_id to "instance-group".
*/
resource "google_service_account" "instance-group" {
  account_id = "instance-group"
}

/*

  This block of code defines a Terraform module named "instance_template".
  The module uses the "terraform-google-modules/vm/google//modules/instance_template" module source with a version
  constraint of "~> 8.0".
  It specifies the subnetwork to use, the source image family and project, and the rendered startup script.
  The service_account block sets the email to the email address of the "google_service_account.instance-group"
  resource and scopes to ["cloud-platform"].

  what does the module do?
  the module named "instance_template" is used to create a reusable template for a virtual machine instance in 
  Google Cloud Platform

  why do we need a service account for the module?
  The module "instance_template" creates a virtual machine instance template on Google Cloud Platform. To create this
  template, the module requires permissions to access Google Cloud Platform APIs.
  To avoid using the default service account or the user's personal credentials, which could be insecure and
  difficult to manage, the module creates a dedicated service account with the necessary permissions to access the
  Google Cloud Platform APIs.
  The service account is specified in the "service_account" variable of the module, which includes the email
  address of the service account and the scopes that it requires. These scopes are used to grant the service account 
  access to the specific APIs that are required for the module to function properly.
  By using a dedicated service account, the module is more secure and easier to manage. The service account can
  be managed separately from other accounts, and its permissions can be restricted to only the APIs that are 
  required for the module to function. Additionally, if the service account credentials are compromised, they 
  can be revoked without affecting other accounts or services.

*/


module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "~> 8.0"
  subnetwork           = google_compute_subnetwork.subnetwork.self_link
  source_image_family  = var.image_family
  source_image_project = var.image_project
  startup_script       = data.template_file.instance_startup_script.rendered

  service_account = {
    email  = google_service_account.instance-group.email
    scopes = ["cloud-platform"]
  }
}

/*
This Terraform code defines a module named "managed_instance_group" that creates a managed instance group (MIG)
in Google Cloud Platform.
The module uses the "terraform-google-modules/vm/google//modules/mig" module, version 8.0, as its source.

The module creates an MIG with a target size of 2, and a hostname of "mig-simple".
It also specifies the region where the MIG will be created using the "region" variable, which is passed
in from the parent module.
The MIG uses the instance template created by the "instance_template" module, which is passed in
as the "instance_template" parameter.

The MIG is associated with three target pools, specified using the "target_pools" parameter.
These target pools are created by other modules. The MIG is also configured with a named port "http"
on port 80, using the "named_ports" parameter.

Overall, this code creates a managed instance group that can automatically scale up or down based on demand,
and is associated with the specified target pools and named ports.
*/

module "managed_instance_group" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "~> 8.0"
  region            = var.region
  target_size       = 2
  hostname          = "mig-simple"
  instance_template = module.instance_template.self_link

  target_pools = [
    module.load_balancer_default.target_pool,
    module.load_balancer_no_hc.target_pool,
    module.load_balancer_custom_hc.target_pool
  ]

  named_ports = [{
    name = "http"
    port = 80
  }]
}

/*
This code defines a Terraform module named "load_balancer_default" which creates a Google Cloud Platform
(GCP) load balancer.
The module takes several input variables such as the load balancer name, region, service port, network name,
and target service account email.
- The source parameter specifies that the module is defined locally in the same directory ("../../") as the 
  root module.
  git clone https://github.com/GoogleCloudPlatform/terraform-google-lb ; cd ~/terraform-google-lb/examples/basic

The name parameter specifies the name of the load balancer that will be created in GCP.

The region parameter specifies the region where the load balancer will be created.

The service_port parameter specifies the port that the load balancer will listen on.

The network parameter specifies the name of the GCP network that the load balancer will be created in.

The target_service_accounts parameter is an array of email addresses for the service accounts that the 
load balancer will direct traffic to. In this code, it points to the email address of the service account defined 
in the google_service_account.instance-group resource.
*/

module "load_balancer_default" {
  name         = "basic-load-balancer-default"
  source       = "../../"
  region       = var.region
  service_port = 80
  network      = google_compute_network.network.name

  target_service_accounts = [google_service_account.instance-group.email]
}

module "load_balancer_no_hc" {
  name                 = "basic-load-balancer-no-hc"
  source               = "../../"
  region               = var.region
  service_port         = 80
  network              = google_compute_network.network.name
  disable_health_check = true

  target_service_accounts = [google_service_account.instance-group.email]
}

module "load_balancer_custom_hc" {
  name         = "basic-load-balancer-custom-hc"
  source       = "../../"
  region       = var.region
  service_port = 8080
  network      = google_compute_network.network.name
  health_check = local.health_check

  target_service_accounts = [google_service_account.instance-group.email]
}
