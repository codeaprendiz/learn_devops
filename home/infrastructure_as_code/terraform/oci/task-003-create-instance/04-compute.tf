

resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.TF_VAR_COMPARTMENT_SANDBOX_TF_V1_OCI_ID
    shape = var.VAR_UBUNTU_SHAPE
    source_details {
        source_id = var.TF_VAR_UBUNTU_MUMBAI_SOURCE_OCI_ID
        source_type = "image"
    }

    # Optional
    display_name = var.VAR_INSTANCE_DISPLAY_NAME
    create_vnic_details {
        assign_public_ip = true
        subnet_id = var.TF_VAR_COMPARTMENT_SANDBOX_TF_V1_PUBLIC_SUBNET_OCI_ID
    }
    metadata = {
        ssh_authorized_keys = file(var.TF_VAR_SSH_PUBLIC_KEY_PATH)
    } 
    preserve_boot_volume = false
}