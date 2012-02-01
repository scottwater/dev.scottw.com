---
layout: post
title: "Resque Mail Queue Gem"
date: 2011-09-07 07:29
comments: true
categories: 
---

I have written two times ([Simple Resque Mail Queue](http://www.scottw.com/simple-resque-mail-queue) and [Simple Resque Mail Queue II](http://www.scottw.com/simple-resque-mail-queue-ii)) before about a simple module _MailQueue_ which can be used to easily send email asynchronously with [Resque](http://github.com/defunkt/resque). 

<!--more-->

Thanks to [Les Hill's](https://twitter.com/leshill/) really simple instructions on [writing your own gemspec](http://blog.leshill.org/blog/2011/08/21/write-your-own-gemspec.html), I have finally published it as a ruby gem: [resque\_mail\_queue](https://github.com/scottwater/resque_mail_queue).

Assuming you already have Resque installed, to use it, you simply need to add this to your GemFile:

```ruby
	gem 'resque\_mail\_queue'
```

From there, similar to the previous examples, to use it simply add _enqueue_ before you Action Mailer methods:

```ruby
	UserMailer.enqueue.welcome_email(1)
```

The version is set at 0.2.0, but I am not expecting too many changes. I will bump it to 1.0 as soon as I add a custom matcher for cleaner specs and get some additional outside feedback. 

If you are using the previous Gist versions, here are the changes I made: 

1. No dependency on Active Support. This is probably not a big deal for most rails projects, but less dependencies is always a good thing. 
1. The object passed to Resque is now the mailer class instead of MailQueue. This makes specs a little cleaner to read since you are referencing the actual mailer.
1. The queue the emails are placed in can now be changed per mailer.
1. The module is now injected into ActionMailer::Base and available on all of your mailers.

This was my first _real_ gem. So if you see anything odd in it, please let me know.