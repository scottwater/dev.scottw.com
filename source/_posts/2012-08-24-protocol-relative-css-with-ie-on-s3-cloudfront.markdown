---
layout: post
title: "Protocol-Relative css with ie on S3 and CloudFront"
date: 2012-08-24 11:12
comments: true
categories: 
---

[Protocol relative](http://paulirish.com/2010/the-protocol-relative-url/) resource allow you to avoid writing code which checks for http:// or https:// (or simply defaulting to one or the other). The benefit, besides less code and complexity, is your visitors will have the resources optimally served to them (fast and not secure or slower and secure). 

This has been around forever (in terms of the web) and every browser handles it perfectly for JavaScript, CSS, images, etc.....well, not quite everyone. As usual, someone invited Internet Explorer to the party and they had to go screw things up. 

As was mentioned in Paul Irish's article above, [IE7 and IE8 download the file twice](http://www.stevesouders.com/blog/2010/02/10/5a-missing-schema-double-download/). Annoying, but  if you are going to use IE 7 or 8 that's what you get. 

Unfortunately, I cam across another baffling issue. 

We host most of our external resources on S3 and CloudFront. A link to a CSS file looked like this: 

	<link href="//random.cloudfront.net/directories/file.css" type="text/css" media="all" />
	
Now I would have expected IE7 and IE8 to download the file twice. Again, annoying, but what can you do? 

Unfortunately, instead of just requesting the file at both http:// and https:// it appends current domain name to the file. 

So instead of requesting http(s)://random.cloudfront.net/directories/file.css it instead requests http://mydomainname.com/random.cloudfront.net/directories/file.css. 

Anyway, not much you can do to fix it except for denying IE7/IE8 or appending https:// for CSS requests. 

Hopefully this post saves someone else out there many hours of head shaking and fist pumping. 

