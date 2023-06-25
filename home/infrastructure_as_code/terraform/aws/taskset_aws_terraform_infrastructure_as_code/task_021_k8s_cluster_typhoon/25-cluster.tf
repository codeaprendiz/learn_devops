module "tempest" {
  source = "git::https://github.com/poseidon/typhoon//aws/container-linux/kubernetes?ref=v1.18.5"

  # AWS
  cluster_name = "k8s118"
  dns_zone     = var.dns_zone
  dns_zone_id  = var.zone_id

  # configuration
  ssh_authorized_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCaqppA0jzSJgZHXIgTnG/8eaeZNX78DBc1R9JnWe0LBf2BaYl73ttoVMMiEbeBWV+d9EHjF617yOW29f5ju5UADN1/khzLceWadczG03vqdRt78Y6kh6kDkVen4+BGtvsWxCYXPP5awGordU4SvRjXl4JfPUct2H8ixvCiret2qktC02MUkTVlVFaYVqqRXkZR6S4uD3UdWTHmL3zy5X0r714uFm45ycH52W4lppI9s7LpnEsUTNU/6Eim0XJ936+uQ+cZ/CULnEf/WAFLaVHxAyp+4VaLQc6WViB32FRbeRTl8V9wxT+1xBUn/0ptZkMO2R7wbcs7/QZwZ2a5UAzv visionary@rathi"

  # optional
  worker_count = 1
  worker_type  = "t2.micro"
}

resource "local_file" "kubeconfig-tempest" {
  content  = module.tempest.kubeconfig-admin
  filename = "/home/visionary/workspace/terraform-kitchen/aws/task-021-k8s-cluster-typhoon/auth/kubeconfig"
}