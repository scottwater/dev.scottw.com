---
layout: post
title: "Heroku SSL via DNSimple"
date: 2011-11-22 09:56
comments: true
categories: 
---
If you google for Heroku SSL you will find a surprisingly long list of blog posts usually with many steps. 

However, it is actually much easier than what most of them list, especially if you are using [DNSimple](https://dnsimple.com/r/a2fb5da9458e27) (note: affiliate link).

Here is how to setup a __Hostname Based__ certificate on Heroku:
<!--more-->
_Note: For wildcard certificates check out [Ryan McGeary's blog post](http://ryan.mcgeary.org/2011/09/16/how-to-add-a-dnsimple-ssl-certificate-to-heroku/)._

1. Head over to [DNSimple](https://dnsimple.com/r/a2fb5da9458e27) and buy a certificate.
1. After you click purchase, DNSimple will give you a private key. Download and save this to a file called private.key. 
1. After jumping through a couple hoops with RapidSSL you will receive an email with 2 certificates. Save the first (web server certificate) as web.crt and the second (intermediate) as chain.crt. 
1. You will now need to combine these two files. cat web.crt chain.crt > domain.pem did the trick for me with **ONE** major exceptions. There needs to be a line break between END CERTIFICATE and BEGIN CERTIFICATE (web and chain). This could be a copy and paste issue on my part, but they were not separated and caused an issue.
1. Now you can add them to Heroku with: _heroku ssl:add domain.pem private.key_
1. Next enable the cert on Heroku: _heroku addons:add ssl:hostname_
1. Finally, in a minute or two you will receive an email with CNAME you need add to your DNS settings. 

The file names private.key, web.crt, chain.crt, and domain.pem should be named something more appropriate for your domain. The exact names have no meaning. 