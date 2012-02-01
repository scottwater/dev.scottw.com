---
layout: post
title: "Octopress Customizations"
date: 2011-08-23 09:39
comments: true
categories: 
---

Here is a quick list of non-style changes I made before deploying my [Octopress](http://octopress.org) site ([see it all on Github](https://github.com/scottwater/scottw.com)): 

<!--more-->

1. Permalinks only contain the title. No need for other dates/etc. (permalink: /:title in _config.yml) 

1. Moved archives out of the blog directory. I am not going to write a post called archives (at least I hope not), so there is no need for the extra directory. 

1. Added a [404 page](https://github.com/scottwater/scottw.com/blob/53f501550cf4f2a1c95b6f16417c2e6cdf131828/source/404.html). 

1. Swapped the order of [page title and site title](https://github.com/scottwater/scottw.com/blob/master/source/_includes/head.html). All sites should do this. Might send this as a pull request. 

1. Added the about me aside to my sidebar (custom/asides/about.html)

1. Added rel="author" to the [author include](https://github.com/scottwater/scottw.com/blob/master/source/_includes/post/author.html). 

1. Wired up the excellent [Rack-Rewrite](https://github.com/jtrupiano/rack-rewrite) for handing old urls and forcing all requests to one domain. 

``` ruby

	use Rack::Rewrite do
	  r301 %r{.*}, 'http://www.scottw.com$&', :if => Proc.new {|rack_env|
	    rack_env['SERVER_NAME'] != 'www.scottw.com' && ENV['RACK_ENV'] == 'production'
	  }
  
	  r301 %r{^/life|code|business|software(/.+)}, '$1'
	  r301 %r{^/archive$}, '/archives'
	  r301 %r{^(.+)/$}, '$1'
	  r301 %r{^/tags}, '/'
	  r301 %r{^/atom$}, '/atom.xml'  
	end
	
```

_Note: The 404 and rewrites only works with Octopress because I am using a Ruby (Heroku) host._