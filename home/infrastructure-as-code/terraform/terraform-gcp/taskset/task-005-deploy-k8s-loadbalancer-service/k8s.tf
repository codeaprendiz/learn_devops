/*
Why do I need to create a provider for kubernetes?

In Terraform, a provider is a plugin that is responsible for managing and interacting with a specific service
or technology, such as Kubernetes. The provider allows Terraform to manage Kubernetes resources by using
the Kubernetes API server.

By creating a Kubernetes provider, Terraform can authenticate with the Kubernetes API server and
perform operations on Kubernetes resources, such as creating, updating, or deleting Kubernetes objects.
The provider block in the Terraform configuration file contains the necessary authentication and connection
information for Terraform to communicate with the Kubernetes API server.

Without a provider, Terraform cannot manage Kubernetes resources, as it does not have a way to authenticate
with the Kubernetes API server or understand the specific syntax required to interact with Kubernetes objects.
*/


# Configure Kubernetes provider with version and authentication information
provider "kubernetes" {
  # Declare the Kubernetes provider and specify its version
  version = "~> 1.10.0"

  # Set the Kubernetes API server endpoint to be the endpoint of the default container cluster
  host    = google_container_cluster.default.endpoint

  # Set the authentication token to be the access token of the current Google Cloud Platform client configuration
  token   = data.google_client_config.current.access_token

  # Decode the client certificate, client key, and cluster CA certificate using the base64decode function
  client_certificate = base64decode(
  google_container_cluster.default.master_auth[0].client_certificate,
  )
  client_key = base64decode(google_container_cluster.default.master_auth[0].client_key)
  cluster_ca_certificate = base64decode(
  google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}

# Create a Kubernetes namespace for staging environment
resource "kubernetes_namespace" "staging" {
  metadata {
    name = "staging"
  }
}

# Create a Google Compute Engine address to use as load balancer IP for the Kubernetes service
resource "google_compute_address" "default" {
  name   = var.network_name
  region = var.region
}

# Create a Kubernetes service to expose the nginx pods in the staging namespace
resource "kubernetes_service" "nginx" {
  metadata {
    namespace = kubernetes_namespace.staging.metadata[0].name
    name      = "nginx"
  }

  spec {
    selector = {
      run = "nginx"
    }

    # Set session affinity to ClientIP
    session_affinity = "ClientIP"

    # Define port configuration for the service
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    # Use LoadBalancer type and assign the previously created Compute Engine address as load balancer IP
    type             = "LoadBalancer"
    load_balancer_ip = google_compute_address.default.address
  }
}

/*
Why do we need to create a replication controller ?

In Kubernetes, a replication controller is used to manage and ensure the availability of a specified number
of replicas (identical copies) of a pod. Replication controllers help to maintain the desired state of the
cluster by ensuring that the specified number of replicas is always running, and if a replica goes down,
a new one is created to replace it.

In the example provided, the replication controller is being used to manage the creation and availability
of nginx pods in the staging namespace. This helps to ensure that a specified number of replicas of the nginx
pod are always available, and if any pod goes down, the replication controller will automatically
create a new replica to replace it, thus ensuring high availability and fault tolerance for the nginx application

*/
# Create a Kubernetes replication controller to manage the nginx pods in the staging namespace
resource "kubernetes_replication_controller" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.staging.metadata[0].name

    # Define labels to match with the selector in the Kubernetes service
    labels = {
      run = "nginx"
    }
  }

  spec {
    selector = {
      run = "nginx"
    }

    # Define the pod template with container specification
    template {
      metadata {
        name = "nginx"
        labels = {
          run = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"

          # Define resource limits and requests for the nginx container
          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }

            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

# Output the load balancer IP address
output "load-balancer-ip" {
  value = google_compute_address.default.address
}
