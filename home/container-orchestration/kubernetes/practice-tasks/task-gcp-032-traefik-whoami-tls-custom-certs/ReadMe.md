## To deploy traefik on GKE with whoami service and with custom TLS certificates


- Assuming that you have the certificates already, please visit visit [here](https://www.base64encode.org/) and 
    - convert your `star_domain.com.key` to base64 and paste the value in `12-secret.yaml`
    - convert your `star_domain_com.chained.crt` to base64 and paste the value in `12-secret.yaml`
    

- Create the secret using `kubectl apply -f 12-secret.yaml`

- Now create the rest of the resources using `kubectl apply -f .`




