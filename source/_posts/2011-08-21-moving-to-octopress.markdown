---
layout: post
title: "Moving to Octopress"
date: 2011-08-21 23:03
comments: true
categories: 
---

If you are reading this, my move to [Octopress](http://octopress.org/) should be complete. 

Octopress is a framework built on [Jekyll](https://github.com/mojombo/jekyll) and maintained by [Brandon Mathis](http://brandonmathis.com/). It adds two killer features to Jekyll. 

<!--more-->

1. A simple theme/template with easy to follow conventions
1. A nice community contributing patches/plugins/etc. 

Most people appear to run Octopress on GitHub pages. This is a great choice, but for this site, I decided to stay on [Heroku](http://heroku.com). 

1. Everything else I host is now on Heroku.
1. I have some old urls I want to handle with redirects, so I need the ability to execute some code. 

Octopress just about works out of the box on Heroku. The only change your absolutely need to make is to remove the _public_ folder from your .gitignore file. 

However, there was one other change I made in [my own Octopress fork](https://github.com/scottwater/octopress). 

Octopress comes with a simple rack server you can use to preview the site locally. For most users this should work quite well. Unfortunately, the included server has two minor draw backs for production usage: 

1. It always sets the content type to text/html for each file request. 
1. It does not honor/set other http conventions such as last_modified_headers. 

Many moons ago, I mucked around with [Rack_Jekyll](https://github.com/bry4n/rack-jekyll). Then I wrote a [simple alternative](http://www.scottw.com/sinatra-jekyll-server) using [Sinatra](http://sinatrarb.com). 

I figured why not try the same thing, so I forked Ocotopress, swapped out the code, and added a dependency to Sinatra. There is of course the extra dependency on Sinatra, but for that you get just about everything done right almost no code. 

I am going to submit a pull request shortly. Hopefully they accept it. If not, feel free to just start your new Octopress site with my fork. 

