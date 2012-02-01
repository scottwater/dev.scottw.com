---
layout: post
title: "Octopress Tips"
date: 2011-08-25 17:38
comments: true
categories: 
---

I am really digging using [Octopress](http://octopress.org) (see [Moving to Octopress](http://www.scottw.com/moving-to-octopress) and [Octopress Customizations](http://www.scottw.com/octopress-customizations)). 

Here are a couple of tips to make your experience using it even better. 

<!--more-->

1. Be willing to delete posts. Every post in Octopress carries some kind of _generate cost_. If the post is no longer relevant relevant/helpful/etc, delete it. Nothing from the web is ever truly deleted, so don't think you can erase something stupid. However, there is no reason to keep junk around. Besides, since your blog lives in git, you can always resurrect the post in the future. 

1. At least for me, writing is a trial and error process. I write something, review it, rewrite it, etc. Waiting for your site to recompile (even using watcher) can be a drag once you get past a hand full of posts. If you run _rake isolate['post-name']_ Octopress will hide all your other posts and allow your site to be regenerated much quicker. When you are all done execute _rake integrate_ and everything comes back. And of course since you are using git nothing is ever really gone anyway. 

1. &lt;!--more--&gt; is your friend against duplicate content. You can place this anywhere in your post to mark an excerpt. I like doing this for older posts to keep my lists small and tidy. 

1. Use [Pow](http://pow.cx) to preview your site locally. I have mine wired up to scottw.dev. Now anytime I need to review something locally it is ready. Run rake watcher while writing and it will (almost) always be up to date. 

1. Do not forget you can preview both markdown and textile via Vim and Textmate. You will not get the full benefit of Octopress's plugins, but it is a really quick way to preview your post.

Any other suggestions? 