### Objective : Create a private certificate for your Domain using AWS Certificate Manager

#### PRE-REQUISITE
- You own a domain for example in following case I own - `ankitrathi.info`
![](../../../images/terraform/task-024-certificate-manager/route53_dashboard.png)

![](../../../images/terraform/task-024-certificate-manager/route53_dashboard_registered_domains.png)

- You should also have a default hosted zone
![](../../../images/terraform/task-024-certificate-manager/route53_hosted_zones.png)


#### Let's Begin
- Go to AWS Certificate Manager

- Choose the region as `us-east-1`
```bash
### WHY
Error: error creating CloudFront Distribution: InvalidViewerCertificate: The specified SSL certificate doesn't exist, isn't in us-east-1 region, isn't valid, or doesn't include a valid certificate chain.
        status code: 400, request id: *****
```

- Click on `Get started`

![](../../../images/terraform/task-024-certificate-manager/cert_manager_provision_certificates.png)


- Now choose `Request a public certificate` and click on `Request a certificate`

![](../../../images/terraform/task-024-certificate-manager/cert_manager_request_a_public_certificate.png)




- Now add the following domain names (assuming that you own the first domain, for which you are creating the public certificate)
  - ankitrathi.info
  - *.ankitrathi.info

![](../../../images/terraform/task-024-certificate-manager/cert_manager_add_domain_names.png)  

- Choose the validation method as `DNS Validation` and hit next

![](../../../images/terraform/task-024-certificate-manager/cert_manager_select_validation_method.png)

- Give tags if required

- Review and confirm

![](../../../images/terraform/task-024-certificate-manager/cert_manager_review.png)


- Now click on the `Create record in Route 53` for creating the records for validation

![](../../../images/terraform/task-024-certificate-manager/cert_manager_validation.png)

![](../../../images/terraform/task-024-certificate-manager/cert_manager_create_record_in_route_53.png)
  
You will see a success message. Finally click on continue.

- Now you will see that the `Validation` is in pending state

- Wait for sometime and you should see `Validation Complete`. Meanwhile you can go to Route 53 and check the two CNAMES you just added


![](../../../images/terraform/task-024-certificate-manager/cert_manager_validation_success.png)

- Now you can use the certificate `ARN` visible on the above screen where-ever you need.
  It will be of following type
```bash
arn:aws:acm:us-east-1:***********:certificate/*****-****-****-****-********
```



 
