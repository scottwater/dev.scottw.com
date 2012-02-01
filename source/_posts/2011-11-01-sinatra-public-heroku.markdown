---
layout: post
title: "Static Files using Sinatra::Base on Heroku"
date: 2011-11-01 10:11
comments: true
categories: 
---

I deployed a small [Sinatra](http://www.sinatrarb.com/) app last night to [Heroku](http://www.heroku.com) for the new [KickoffLabs API](http://api.kickofflabs.com). 

Most of the Sinatra apps I have deployed in the past have been small prototypes and used the inline Sinatra app style. 

However, in this case, I made the decision early on to use the Sinatra::Base class style since we plan on growing the API codebase (ie, we are going to keep it around for a long time). 
<!--more-->

Everything was working as expected locally, but once I deployed to Heroku none of the static files in the public directories were rendering properly (all were 404'ing). 

It turns out that when you use the Sinatra::Base class style, you need to set the public directory explicitly like this: 

``` ruby
class KickoffAPI < Sinatra::Base 
	set :public, 'public'
end
```

Now this makes a lot of sense since in hindsight, but took me longer than I would like to admit to figure out. Hopefully this post and a little Google foo will save others a couple of hours. 