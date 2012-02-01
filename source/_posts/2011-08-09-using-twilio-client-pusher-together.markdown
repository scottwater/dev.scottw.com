---
layout: post
title: "Using Twilio Client and Pusher Together"
date: 2011-08-09 20:46
comments: false
---

Last week I started building a fun new project, [DearEmmy](http://www.dearemmy.com) (more on this shortly). DearEmmy makes use of [Twilio's](http://twilio.com) [new client](http://www.twilio.com/api/client) feature as well as [Pusher](http://pusherapp.com) for real time updates. 

Everything was going great, until I fired up Internet Explorer[1] and saw just about nothing in the app was working.

<!--more-->

As a good web developer, my first thought was, _damn you IE_. After digging through the errors, they seemed to point to a conflict between Twilio and Pusher. 

After a couple of support emails I learned both Twilio and Pusher are using the [websocket-js](https://github.com/gimite/web-socket-js) library. This library enables browsers without websocket to act like real browsers and most importantly, there was indeed a conflict. 

Both companies have acknowledged the bug and hopefully by the time you read this it will be resolved (look for an update below).

However, for better or worse I am impatient and started to look for a fix. I tried various methods of loading the scripts on demand which didn't work. I then moved the Pusher scripts to an iframe to isolate them from the main page. This worked great in Safari/Chrome, but failed in the same miserable way in IE and FF. 

Then, on a whim, I decided to swap the script order. Instead of loading Twilio first and Pusher second, I changed it to load Pusher before Twilio.  And now, everything works in IE, FireFox, Safari, and Chrome.

I really hate not knowing why this worked, but I am confident the smart folks at Twilio and Pusher will figure it out. I can now go back to getting real work done. 

[1] I  later learned the bug also exists in FireFox which pretty much confirmed it was related to flash..._damn you Adobe_.
