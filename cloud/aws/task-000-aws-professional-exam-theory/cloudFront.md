# Cloudfront

[Cheat Sheet - Cloudfront](https://tutorialsdojo.com/amazon-cloudfront)

[geoproximity-routing-vs-geolocation-routing](https://tutorialsdojo.com/latency-routing-vs-geoproximity-routing-vs-geolocation-routing)

[What is Amazon CloudFront?](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

Amazon CloudFront is a web service that speeds up distribution of your static and dynamic web content, such as .html, .css, .js, and image files, to your users. CloudFront delivers your content through a worldwide network of data centers called edge locations. When a user requests content that you're serving with CloudFront, the request is routed to the edge location that provides the lowest latency (time delay), so that content is delivered with the best possible performance.

- If the content is already in the edge location with the lowest latency, CloudFront delivers it immediately.

- If the content is not in that edge location, CloudFront retrieves it from an origin that you've defined—such as an Amazon S3 bucket, a MediaPackage channel, or an HTTP server (for example, a web server) that you have identified as the source for the definitive version of your content.


## Restricting the geographic distribution of your content

[Restricting the geographic distribution of your content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/georestrictions.html)

You can use geo restriction, also known as geo blocking, to prevent users in specific geographic locations from accessing content that you're distributing through a CloudFront distribution. To use geo restriction, you have two options:

- Use the CloudFront geo restriction feature. Use this option to restrict access to all of the files that are associated with a distribution and to restrict access at the country level.

- Use a third-party geolocation service. Use this option to restrict access to a subset of the files that are associated with a distribution or to restrict access at a finer granularity than the country level.

## Optimizing Caching and availability

### Optimizing high availability with CloudFront origin failover

[Optimizing high availability with CloudFront origin failover](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/high_availability_origin_failover.html)


- You can set up CloudFront with origin failover for scenarios that require high availability. 
- To get started, you create an origin group with two origins: a primary and a secondary. 
- If the primary origin is unavailable, or returns specific HTTP response status codes that indicate a failure, CloudFront automatically switches to the secondary origin.


## Configuring secure access and restricting access to content

### Using field-level encryption to help protect sensitive data

[Using field-level encryption to help protect sensitive data](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/field-level-encryption.html)

- With Amazon CloudFront, you can enforce secure end-to-end connections to origin servers by using HTTPS
- Field-level encryption adds an additional layer of security that lets you protect specific data throughout system processing so that only certain applications can see it.
- Field-level encryption allows you to enable your users to securely upload sensitive information to your web servers.
- The sensitive information provided by your users is encrypted at the edge, close to the user, and remains encrypted throughout your entire application stack. 
- This encryption ensures that only applications that need the data—and have the credentials to decrypt it—are able to do so.
- To use field-level encryption, when you configure your CloudFront distribution, specify the set of fields in POST requests that you want to be encrypted, and the public key to use to encrypt them. 
- You can encrypt up to 10 data fields in a reques


### Using AWS WAF to control access to your content

[Using AWS WAF to control access to your content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-awswaf.html)

- AWS WAF is a web application firewall that lets you monitor the HTTP and HTTPS requests that are forwarded to CloudFront, and lets you control access to your content
- Based on conditions that you specify, such as the values of query strings or the IP addresses that requests originate from, CloudFront responds to requests either with the requested content or with an HTTP status code 403 (Forbidden). 

### Restricting access to Amazon S3 content by using an origin access identity (OAI)

[Restricting access to Amazon S3 content by using an origin access identity (OAI)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html)

To restrict access to content that you serve from Amazon S3 buckets, follow these steps:
- Create a special CloudFront user called an origin access identity (OAI) and associate it with your distribution
- Configure your S3 bucket permissions so that CloudFront can use the OAI to access the files in your bucket and serve them to your users. Make sure that users can’t use a direct URL to the S3 bucket to access a file there.

### Restricting access to files on custom origins

[Restricting access to files on custom origins](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-overview.html#forward-custom-headers-restrict-access)

- If you use a custom origin, you can optionally set up custom headers to restrict access. 
- But by using custom headers, you can further restrict access to your content so that users can access it only through CloudFront, not directly. 
- To require that users access content through CloudFront, change the following settings in your CloudFront distributions:
  - Origin Custom Headers: Configure CloudFront to forward custom headers to your origin.


## Optimizing caching and availability

### Increasing the proportion of requests that are served directly from the CloudFront caches (cache hit ratio)

[Increasing the proportion of requests that are served directly from the CloudFront caches (cache hit ratio)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cache-hit-ratio.html)

- You can improve performance by increasing the proportion of your viewer requests that are served directly from the CloudFront cache instead of going to your origin servers for content. 
- This is known as improving the cache hit ratio.

- Specifying how long CloudFront caches your objects
  - To increase your cache hit ratio, you can configure your origin to add a Cache-Control max-age directive to your objects, and specify the longest practical value for max-age


### Requiring HTTPS for communication between viewers and CloudFront

[Requiring HTTPS for communication between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-viewers-to-cloudfront.html)

- You can configure one or more cache behaviors in your CloudFront distribution to require HTTPS for communication between viewers and CloudFront. 
- You also can configure one or more cache behaviors to allow both HTTP and HTTPS, so that CloudFront requires HTTPS for some objects but not for others. 
- The configuration steps depend on which domain name you're using in object URLs:

  - If you're using the domain name that CloudFront assigned to your distribution, such as d111111abcdef8.cloudfront.net, you change the Viewer Protocol Policy setting for one or more cache behaviors to require HTTPS communication. In that configuration, CloudFront provides the SSL/TLS certificate.
  - If you're using your own domain name, such as example.com, you need to change several CloudFront settings. You also need to use an SSL/TLS certificate provided by AWS Certificate Manager (ACM), or import a certificate from a third-party certificate authority into ACM or the IAM certificate store.


## Blogs

[How do I use CloudFront to serve a static website hosted on Amazon S3?](https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-serve-static-website)

