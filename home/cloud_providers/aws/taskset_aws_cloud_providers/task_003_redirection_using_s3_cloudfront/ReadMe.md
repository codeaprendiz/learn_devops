### Redirect Apex domain to another domain's subdomain with browser change in URL

Requirements

- firstdomain.com should be redirected to https://sub.seconddomain.com
- http://firstdomain.com should be redirected to https://sub.seconddomain.com
- https://firstdomain.com should be redirected to https://sub.seconddomain.com


Documents Referred

[https://aws.amazon.com/premiumsupport/knowledge-center/route-53-redirect-to-another-domain](https://aws.amazon.com/premiumsupport/knowledge-center/route-53-redirect-to-another-domain)

[stackoverflow](https://stackoverflow.com/questions/10115799/set-up-dns-based-url-forwarding-in-amazon-route53/14289082#14289082)


#### S3 configuraton

- Name of the bucket : firstdomain.com
- Enable the static website hosting and Redirect requests for an object and set the `Hostname` to `sub.seconddomain.com`. Protocol should be `https`
- Keep a copy of the website endpoint `http://firstdomain.com.s3-website.ap-south-1.amazonaws.com`


### CloudFront configuration

- Create cloudfront distribution with alternamte domain name as `firstdomain.com`
- You will need to create an ACM certificate in `us-east-1` for the CloudFront, ensure that the 
  ACM certificate supports the domians `*.firstdomain.com`, `firstdomain.com`, `www.firstdomain.com`, `*.seconddomain.com`, `seconddomain.com`, `www.seconddomain.com`
- Keep the origin domain as `firstdomain.com.s3-website.ap-south-1.amazonaws.com`, what noted in previous step without the `http`
- Origin Protocol should be `http` as for S3-website configuration only supports http requests. So the http port will also be 80
- Viewer, protocol policy `Redirect HTTP to HTTPS`
- You can keep all the HTTP methods as allowed
- Make a not of the distribution domain name `https://something.cloudfront.net`


### Route53 configuration

- Go to the hosted zone `firstdomain.com` 
- Create an `Alias A IPv4` record for `firstdomain.com` pointing to `something.cloudfront.net`


### Validation

- When there is `cache miss` from the cloudfront

```bash
$ curl -I http://something.cloudfront.net -L
HTTP/1.1 301 Moved Permanently
Server: CloudFront
Date: Thu, 12 Aug 2021 12:12:04 GMT
Content-Type: text/html
Content-Length: 183
Connection: keep-alive
Location: https://something.cloudfront.net/
X-Cache: Redirect from cloudfront
Via: 1.1 5dd0dcc9e0464f63fa9f8c3a40.cloudfront.net (CloudFront)
X-Amz-Cf-Pop: DEL54-C4
X-Amz-Cf-Id: 5kX-_t55pHGTMaZt046sbSyS9geMsw8RagPXNGdiqthnV9HEJc18Rw==

HTTP/2 301
content-length: 0
location: https://sub.seconddomain.com/
date: Thu, 12 Aug 2021 12:12:05 GMT
server: AmazonS3
x-cache: Miss from cloudfront
via: 1.1 5ef0432e6c0ac31f0b8bdb72d3755f66.cloudfront.net (CloudFront)
x-amz-cf-pop: DEL54-C4
x-amz-cf-id: nZGDaK7tSmo4hwC6jlT9fLV5rjNglbNajvLtj0y54vROJg18Qislrg==

HTTP/1.1 404 Not Found
Content-Length: 19
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Aug 2021 12:12:04 GMT
X-Content-Type-Options: nosniff
Connection: keep-alive
```

- When there is `hit` from the cloudfront

```bash
$ curl -I http://something.cloudfront.net -L
HTTP/1.1 301 Moved Permanently
Server: CloudFront
Date: Fri, 13 Aug 2021 11:17:07 GMT
Content-Type: text/html
Content-Length: 183
Connection: keep-alive
Location: https://something.cloudfront.net/
X-Cache: Redirect from cloudfront
Via: 1.1 637fcf134a6acd248c904995685d8a65.cloudfront.net (CloudFront)
X-Amz-Cf-Pop: DEL54-C4
X-Amz-Cf-Id: MZa1056r6UIWlshM0FzGsVoAMtdVtkW8-5JMSb2JxngFIkC2kdNT4g==

HTTP/2 301
content-length: 0
location: https://sub.seconddomain.com/
date: Thu, 12 Aug 2021 12:12:05 GMT
server: AmazonS3
x-cache: Hit from cloudfront
via: 1.1 d074672a93d4cecfc24649b988ca81dc.cloudfront.net (CloudFront)
x-amz-cf-pop: DEL54-C4
x-amz-cf-id: lQyKipnkYjneJ27p1ox3-bLEbnrrV49dOIMq8iXyZtP1Q402rPBKEw==
age: 83103

HTTP/1.1 404 Not Found
Content-Length: 19
Content-Type: text/plain; charset=utf-8
Date: Fri, 13 Aug 2021 11:17:07 GMT
X-Content-Type-Options: nosniff
Connection: keep-alive
```


### Issues you might face

- Note that the CNAME is added to the CDN and is supported by the ACM certificate
- Sometimes its just the cloudfront, because it take sometime to reflect the values. You can invalidate the cloudfront cache 
  by using `Cache invalidation` for `*/`
