---
layout: post
title: "Better Rails 3 Logging Output"
date: 2011-06-08 09:50
comments: false
---

I added two gems to my Gemfile today which dramatically improved my local development log output. 

1. [Itslog](https://github.com/johmas/itslog) - The formatting will prepend all log statements with a colored header and additional information about the statement. The information and structure of the new statements is customizable through configuration.
2. [Silent-Postres](https://github.com/dolzenko/silent-postgres) - Silences internal diagnostic messages from postgresql connection adapter.

The only gotcha I had after adding these gems is I needed to switch to the dark iTerm2 [solarized](http://www.scottw.com/solarized) theme to view the Itslog output (although this can be overridden if I really want to use the light background).

Highly recommended. 
