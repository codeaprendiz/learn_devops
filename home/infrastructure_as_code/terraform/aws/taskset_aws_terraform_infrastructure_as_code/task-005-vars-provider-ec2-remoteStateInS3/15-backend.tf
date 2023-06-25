terraform {
  backend "s3" {
    bucket = "terraform-kitchen-remote-state"
    key = "terraform-remote-state-key"
  }
}