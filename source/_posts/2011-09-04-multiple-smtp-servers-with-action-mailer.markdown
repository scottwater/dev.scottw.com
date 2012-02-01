---
layout: post
title: "Multiple Smtp Servers With Action Mailer"
date: 2011-09-04 09:25
comments: true
categories: 
---

We recently started using [PostMark](http://postmarkapp.com) on [KickoffLabs](http://www.kickofflabs.com). So far the service has been excellent. Unfortunately, not all of our emails fit their terms of service. I looked around for how configure an addition SMTP server via Action Mailer (and Mail gem). Surprisingly, this is not supported. 

<!--more-->

However, [this question on StackOverflow](http://stackoverflow.com/questions/2662759/how-to-send-emails-with-multiple-dynamic-smtp-using-actionmailer-ruby-on-rails) helped point me towards a solution.

{% gist 1192857 %}


From here, the Postmarker module can be included in a mailer subclass, or injected in ActionMailer::Base

``` ruby
	class ActionMailer::Base
	  include Postmarker
	end
```

A quick overview of what is happening here: 

1. The Postmarker module adds a new method, postmark_mail, to all of our mailers. I initially tried to simply override mail, but the meta-magic in the mailers was making it too complicated. Also, in the end, there were some emails which passed the Postmarker validation but where not appropriate for Postmark. Put another way, it was simply better to be explicit. 

1. The postmark_mail method calls the main mail method. It then optionally overrides the SMTP server settings if the mail is valid for Postmark (in our case, this is just validating the environment and from address). 

1. postmark_mail simply returns the Mail::Message and everything else progresses as normal. 

In the end, this really has nothing to do with PostMark, so it should be applicable to other providers. I chose to keep it simply and did not worry about further customization. 

One change I would still love to make is supporting multiple _delivery_methods_, but as of now that does not appear feasible. If you have any suggestions, please let me know. 