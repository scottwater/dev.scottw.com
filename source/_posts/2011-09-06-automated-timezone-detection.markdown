---
layout: post
title: "Improving Automated Timezone Detection"
date: 2011-09-06 08:30
---

tl;dr - Just using the Javascript getTimezoneOffset to auto-detect timezone information will not work properly during daylight savings and has a couple of other minor gotchas. Check out the [jsTimezoneDetect](https://bitbucket.org/pellepim/jstimezonedetect/wiki/Home) and my simple [jQuery detect\_timezone plugin](https://github.com/scottwater/jquery.detect_timezone) for more accurate timezone information. I also put together a gem, [detect\_timezone\_rails](https://github.com/scottwater/detect_timezone_rails), to automate the process in Rails.

<!--more-->

### What are we trying to do?

Rails makes it very easy to display dates/times are translated and offset properly for the current user.

The standard approach is to display a list of known timezones (time\_zone\_options\_for\_select) and then take that value and assign it to Time.zone somewhere early in your request. 

With this setting, dates in things like your ActiveRecord models will be translated into your users local time (assuming you know what it is).

### Automate It!

Anytime you can remove an unnecessary task for a user, your application gets better. Timezone selection is increasingly a thing of the past. By now you have probably seen plenty of articles explaining how you do this:

1. Wire up a bit of javascript and grab the value of new Date().getTimezoneOffset()
1. Take this value and store it in a cookie or a hidden field (or just send it to the server via ajax)
1. Use this value to offset time values

In Rails, this is particularly easy because not only does Time.zone accept a string representing the timezone name, but you can also specify an offset directly. 

And this method works perfectly well....until you hit daylight saving time. 

For example, on April 28th in Eastern Standard Time, using getTimezoneOffset() it correctly reported my offset as 14,400 seconds (4 hours). However, this is only because of daylight savings. Normally my offset would be 5 hours. 

Setting my current timezone with a four hour offset gets me close, but ends up putting me off by 1 hour. 

``` ruby
	Time.zone = -240.minutes
	Time.zone # => (GMT-4:00) Atlantic Time (Canada)
	Time.current # =>  Thu, 28 Apr 2011 10:13:03 ADT -03:00
```

Now this kind of makes sense. Setting Time.zone via an offset does not have anyway of knowing whether or not it is daylight savings, so it simply ignores it. Adding even more complexity is the fact there are quite a few timezone overlaps. Running rake time:zones:local shows there are 5 different timezones which are UTC -05:00. So even if I did manage to figure out the offset should be 300 minutes, how would we know which of the five to choose? (btw, it defaults to the first in the list, which for -05:00 is Bogota).

### The Answer

The downer hear is there really is no perfect option here. Timezones are simply a mess and there will always be edge cases. 

However, there is a bit of hope by using [jsTimezoneDetect](https://bitbucket.org/pellepim/jstimezonedetect/wiki/Home). 

> Determining timezones using javascript is not trivial out of the box. Different browsers use different acronyms and conventions for representing names of timezones, it also differs depending on the user's operating system. This little script tries to take a pragmatic approach by using a few simple algorithms using the JavaScript Date object.

With jsTimezoneDetect you can retrieve the Olson timezone name, offset, and whether or not it daylight savings time or not. Even better, with the Olson name you can remove most of the ambiguity in setting the Time.zone. 

We are using jsTimezoneDetect on [KickoffLabs](http://www.kickofflabs.com) and it has worked great. We have never had to ask our customers to choose from a monster list of timezones and we can send them reminders/etc at times that are much more likely to get a response (ie, status emails are sent at 8 am local time). 

I am going to use jsTimezoneDetect in a couple of other projects, so over the past weekend I took some time to automate it's usage. 

1. [jquery.detect\_detect\_timezone](https://github.com/scottwater/jquery.detect_timezone) is a jquery plugin which makes grabbing the Olson timezone name from jsTimezoneDetect trivial.

1. [detect\_timezone\_rails](https://github.com/scottwater/detect_timezone_rails) is a ruby gem which takes advantage of Rails 3.1 asset pipeline. Using the jQuery plugin is optional, but it is nice to have it easily available. 