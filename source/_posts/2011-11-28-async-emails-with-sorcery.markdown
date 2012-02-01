---
layout: post
title: "Async Emails With Sorcery"
date: 2011-11-28 12:27
comments: true
categories: 
---

For [KickoffLabs](http://www.kickofflabs.com), we rolled our own authentication. This worked really well, but doing it (even if we packaged it up) for future projects is less than appealing. 

I have used/tried Devise, Clearance, and AuthLogic but none of them seemed to fit. 

Enter [Sorcery](https://github.com/NoamB/sorcery). Sorcery is a relatively new player in the rails authentication arms race. 

<!--more-->

So far, I am really liking Sorcery[1]. It stays out of the way, has decent documentation, useful testing helpers, etc. 

Unfortunately, out of the box, Sorcery sends emails inline (same UI thread). In local development, this is not an issue. However, in production is this not acceptable. 

Looking through the Sorcery source code, I did not see a configuration hook related to this. But with a little bit of monkey patching, we can alter the behavior:

``` ruby
module Sorcery
  module Model
    module InstanceMethods
      def generic_send_email(method, mailer)
        config = sorcery_config
        mail = config.send(mailer).enqueue.send(config.send(method),self.id)
      end
    end
  end
end
```

In this case, I am simply overriding the generic_send_email method. The enqueue method comes from my own [Resque Mail Queue](https://github.com/scottwater/resque_mail_queue) gem. You could very easily do something similar with delayed_job, etc. 

Since I am using Resque, I also updated my mailer actions to use the user (model) id instead of the user model. Otherwise, nothing else in Sorcery needs to change.

I doubt this is the ideal way to 'fix' this issue, but it works for now and allows me to move forward. 

[1] _Well, I should clarify I am liking the ActiveRecord adapter. I haven't been able to get the Mongoid one working properly...but that could be something on my side._