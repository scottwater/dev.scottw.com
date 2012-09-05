---
layout: post
title: "Even More Efficient with Heroku"
date: 2012-09-05 11:16
comments: true
categories: 
---

I came across this blog post a couple of weeks ago, [Getting efficient when working with Heroku](http://blog.railsonfire.com/2012/05/29/Effective-Heroku.html). 

The tips are definitely good and can save you some time. However, I think you can save yourself even more time and effort if you use your Git remote name instead of your Heroku application name. 

### Using Remotes

Most of the Heroku cli documentation uses -a or --app to specify the specific application. However, instead of using the app name, you can use -r or --remote to specify the name of a remote. 

Knowing this and sticking to some specific naming conventions, you can add the following functions to back or zsh (preferred) profiles:

<script src="https://gist.github.com/3638694.js?file=gistfile1.sh"></script>
<noscript>
	<p>[View the code](https://gist.github.com/3638694)</p>
</noscript>

### Naming Remotes

You can name your remotes when you create your Heroku app with the --remote parameters. You can also rename a remote at any time with the following:

git remote rename [previous__usually__heroku] production

### Using the Code

Now, to run a rake command it is as simple as: 

``` shell
hp run rake db:migrate
hp run console
```

And as a side benefit, deploying now looks like this: 

``` shell
git push production
git push staging
```

### Caveat 

One downside to this approach is you need to execute them from within your app directory. This isn't an issue for me personally, but you will probably need to stick with the app suggestions in the in link above if you want to be able to execute commands from anywhere on your computer.