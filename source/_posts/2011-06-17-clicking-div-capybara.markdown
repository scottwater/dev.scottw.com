---
layout: post
title: "Clicking on a DIV with Capybara"
date: 2011-06-17 14:55
comments: false
---

For the record, I am not sure this is a good practice. In fact, I am pretty for for accessibility it is probably the not the best solution...but for now this is how it works. 

The scenario: 

When selecting a theme in [KickoffLabs](http://www.kickofflabs.com) we allow a user to simply click on a preview image which is wrapped in a div. This executes a bit of javascript and properly stores the selected id so it can be sent to the server and stored in the database. In an earlier version this was simply a select element which [Capybara](https://github.com/jnicklas/capybara) has a simple built in method for (select). Once this was changed to a div (or image) the spec broke. 

Thankfully, the fix is quite simple, just use [find](http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders#find-instance_method) (which returns an element) and execute [click](http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element#click-instance_method). 

``` ruby
	find("#Energy_Blue").click 
```

Also, since this is executing javascript, it requires the use of the javascript driver. 
