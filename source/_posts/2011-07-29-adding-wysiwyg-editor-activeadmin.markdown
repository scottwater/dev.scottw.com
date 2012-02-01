---
layout: post
title: "Adding a WYSIWYG Editor to ActiveAdmin"
date: 2011-07-29 11:04
comments: false
---

[ActiveAdmin](http://activeadmin.info/) is a nice way to quickly build admin pages. Think of it as a scaffolding on steriods. It is probably not ideal for most customers, but you can accomplish quite a bit with minimal effort. 

One of the models I was editing with ActiveAdmin accepts HTML in a textarea. I find the thought of writing even a single angle bracket nauseating these days, so I decided to convert the editor into a WYSIWYG editor with [TinyMCE](http://tinymce.moxiecode.com/). 

ActiveAdmin is a rails engine which plugs directly into your existing app. It provides a nifty little DSL for building UI screens. Getting the editor to work took just a couple of minutes once you understand the basic pieces.

<!--more-->

**First**, download (and install) TinyMCE. I went with the jQuery optimized version. 

**Next**, create a new javascript file in your public/javascripts directory called active_admin_custom.js. In this file we are going to add a little javascript to wire up our editor. 

``` javascript
	$(document).ready(function() {
	  load_editors();
	}); 

	function load_editors(){
	  $('.editor').tinymce({
	 	//removed settings to keep it short.
	  });
	}
```

I took the approach of using a specific CSS class as my selector, but you could use specific ids/etc if that worked better for you. 

**Next**, open up your active_admin.rb initializer, and configure your both tinymce and your custom.js file. 

``` ruby
	config.register_javascript 'tiny_mce/jquery.tinymce.js'
	config.register_javascript 'active_admin_custom.js'
```

From here, the only thing potentially left to do is update your inputs to match the selector you chose (skip this if you went with specific ids). 

Note, Active Admin uses the excellent [Formtastic](https://github.com/justinfrench/formtastic) gem. The trick to add CSS classes is pass a "input_html" hash

``` ruby
	input_html => {:class => 'editor'}
```

FWIW, I generally hate WYSIWYG editors. When possible, I prefer either Markdown or Textile, but sometimes this is beyond your control (this post was written in Markdown).
