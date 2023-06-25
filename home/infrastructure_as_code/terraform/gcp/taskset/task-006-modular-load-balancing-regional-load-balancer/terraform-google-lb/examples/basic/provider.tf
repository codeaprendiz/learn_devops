/*
By using provider blocks, Terraform can manage resources across multiple cloud providers or services. 
In this case, the provider blocks allow Terraform to interact with the Google Cloud Platform using both 
stable and beta versions of the API.
*/

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}
