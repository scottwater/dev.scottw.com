---
layout: post
title: "Octopress Linked List"
date: 2012-02-01 06:39
comments: true
categories: links
external-url: http://www.candlerblog.com/2012/01/30/octopress-linked-list/
---

I have been meaning to implement this on my own for a while. 

I did make one minor adjustment David's example. Instead of inlining the glyph, I am adding it via CSS: 

``` css
a.external-link:after {
  content: " \27A6";
}
```