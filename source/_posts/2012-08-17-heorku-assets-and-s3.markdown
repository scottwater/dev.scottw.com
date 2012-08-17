---
layout: post
title: "Heorku, Assets, and S3"
date: 2012-08-17 09:36
comments: true
categories: 
---

We are just about done on V2 of [KickoffLabs](http://www.kickofflabs.com). One of my side goals has been to finally move our web assets (images, css, and javascript) to S3 (and CloudFront). 

My first attempt was based on this article, [Make your website super fast with Asset Pipeline, Sprites & Cloudfront](http://blog.railsonfire.com/2012/05/18/Assets-Sprites-CDN.html). 

In a nutshell, we used a pass through approach with CloudFront (Amazon's CDN). Assets would be requested on our CloudFront domain. If they did not exist, they would be passed back through to us. Once they were found, they would be cached on the CDN. 

Because the asset pipeline will generate hashed file names, this appeared to be a very effective way to offload our assets. 

This worked pretty well at first, but we started to notice some assets where missing. This may (or may not) be related to switching between SSL and non-SSL. But in the end, we decided the risk was not outweighing the reward. 

Recently, Ben Scheirman wrote an article, [Serving Assets From S3 on Heroku](http://benscheirman.com/2012/07/serving-assets-from-s3-on-heroku). This sounded like the perfect solution, until Ben confirmed in the comments that he had to push assets separately after a deploy. 

This creates a small windows where assets may not be available. Probably not that big of a deal (especially on deploys without new assets), but it was enough for me to temporarily shelve the idea again. 

However, a recent comment on the post mentioned the [asset_sync gem](https://github.com/rumblelabs/asset_sync) will now override the default assets:precompile rake task and will deploy your asset changes when you deploy. 

I have tested this a couple of times this morning on our V2 staging app and it appears to be working perfectly. 

The only big issue we are still seeing is in serving fonts. We use a custom icon font heavily in KickoffLabs. Both FireFox and IE are not fans of fonts being served by different domains without setting Access-Control headers. Unfortunately, although it has often been requested, Amazon will not allow this header to be set on S3. 

The fix (I use that term loosely) is to move our font out of the asset pipeline and server it directly ourselves. This isn't ideal, but at least that limits us to a single asset per request. 

One more bonus tip, if you are serving fonts, check out the [rack-access-control-headers gem](https://github.com/mintdigital/rack-access-control-headers). This will set the proper headers on any fonts you server directly via Rack. 