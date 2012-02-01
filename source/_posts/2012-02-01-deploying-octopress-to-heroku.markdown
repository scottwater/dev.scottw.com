---
layout: post
title: "Deploying Octopress to Heroku With a Custom Buildpack"
date: 2012-02-01 10:09
comments: true
categories: 
external-url: http://jasongarber.com/blog/2012/01/10/deploying-octopress-to-heroku-with-a-custom-buildpack/
---

Why is this important? It means no more committing the public directory into git. 

Even with just 200 or so posts, my git history felt like it was exploding every time I wrote a new post. 

I went ahead and nuked my old blog repo and [recommitted this cleaner](http://github.com/scottwater/scottw.com) (and leaner) version if you need a starting place. 

Jason's steps were great, but I did run into two snags: 

1. I could not set the buildpack directly when creating the app. I had to add the heroku config var for it instead. 
2. I got an error about a missing daemon gem. Heroku's cedar stack is still in beta and running a RC version of bundler (as of today). I haven't dug any further, but nuking my gem vendor folder and starting over seemed to do the trick. 