---
layout: post
title: "Running Pow Over SSL"
date: 2011-06-22 15:12
comments: false
---

We are just about ready to put [KickoffLabs](http://kickofflabs.com) into production mode. One of the last big tasks was setting up SSL.

Obviously, do not we want to push SSL support live without first testing it, so I set out to set it up locally. 

I considered a variety of approaches and eventually settled on using [Pow](http://pow.cx/) with [nginx](http://nginx.net/) as a [reverse proxy](http://en.wikipedia.org/wiki/Reverse_proxy). 

<!--more-->

1. This is simple and lightweight. 
1. Pow doesn't require any additional configuration changes (ie, no host file entries). 

Here are the basic steps. 

1. Install Pow (you are silly if this is not already done)
1. Install nginx. I used [Homebrew](https://github.com/mxcl/homebrew) because I value my time and sanity: brew install nginx
1. By default, your nginx configuration wil be at /usr/local/etc/nginx. Open a terminal window and navigate to this directory.
1. Create a directory here called ssl. (mkdir ssl) 
1. Download [this ruby script](https://gist.github.com/1040281#file_gen_cert.rb) and place it in the ssl directory[1]. 
1. Execute the script _ruby gen_cert.rb kickoff.dev_. The script takes a single argument, the domain name of your site.[2]
1. Replace the nginx.conf file located at /usr/local/etc/nginx/nginx.conf [with this one](https://gist.github.com/1040281#file_nginx.conf). Optionally, you can just copy the server section from the gist and place it in your existing configuration file.
1. Change all of the kickoff.dev references to your own domain name. 
1. Test the nginx configuration with this command: _nginx -t_. It should report back it was successful, but will likely give a warning about permissions. This is because we are specifying port 443 which cannot be used without sudo. 
1. Assuming everything went OK in the last step, you can start nginx with _sudo nginx_.

A couple of things to watch out for: 

1. To run nginx on port 443 (or 80) you need to start nginx with elevated privileges. 
1. If you start nginx and it says it is already bound/running, you can stop it with _nginx -s stop_
1. Make sure you have Pow running
1. Make sure you pick a url that is valid for Pow (anything in .dev)
1. This was my first time playing with nginx. If you stop something odd in the configuration file, please let me know.

Here is another link to the gist with the [cert script and nginx.conf](https://gist.github.com/1040281).

This has been tested on a exactly one computer. Please let me know if you run into any issues. 

[1] This script is based on the [commands listed here](http://www.cyberciti.biz/faq/howto-linux-unix-setup-nginx-ssl-proxy/). You can execute them manually if you want. I did this a couple of times already and decided to automate it. 

[2] I hard coded a bunch of the certificate data. All that matters for testing is the domain (common) name, but feel free to the edit the -subj argument.
