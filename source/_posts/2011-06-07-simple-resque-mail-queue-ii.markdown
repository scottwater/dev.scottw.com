---
layout: post
title: "Simple Resque Mail Queue - II"
date: 2011-06-07 10:19
comments: false
---

Here is a slightly cleaned up version of the simple [Mail Queue](http://www.scottw.com/simple-resque-mail-queue) for [resque](https://github.com/defunkt/resque) I published a couple of weeks ago. 

``` ruby
	module MailQueue
	  extend self

	  def queue
	    :default
	  end

	  def perform(options = {})
	    options = options.with_indifferent_access

	    mailer = options[:klass].constantize
	    method = options[:method]
	    mailer.send(method, *options[:args]).deliver
	  end

	  def enqueue()
	    EnqueueProxy.new(self)
	  end

	  class EnqueueProxy

	    def initialize(klass)
	      @klass = klass
	    end

	    def method_missing(m, *args, &block)
	      if @klass.respond_to? m
	        options = {:klass => @klass.to_s, :method => m, :args => args}
	        Resque.enqueue(MailQueue, options)
	      else
	        super
	      end
	    end

	  end

	end
```

The biggest change is the options are now all stored in a simple hash with keys for the class, method, and extra arguments. The previous version should continue to work, but if you grabbed this code, I recommend updating to this version since it should be easier to maintain (and debug if necessary) in the future.
