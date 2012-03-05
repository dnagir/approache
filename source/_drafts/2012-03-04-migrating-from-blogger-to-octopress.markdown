---
layout: post
title: "Migrating from Blogger to Octopress"
date: 2012-03-04 20:09
comments: true
categories: DevTools, Ruby, Web
---


So I've been a Blogger user for a while and decided to switch over to something more geeky.

This post will cover some of the reasons for that and also will provide an overview
of how to actually migrate it.

What do I want to achieve?
----------------------------

- **Merging** my personal site and blog - those were totally separate, unrelated entities. Wanted to merge the two.
- Write **more often**, using the same tools I use on a daily basis (Vim ATM).
- More **hands on** blog itself, I actually do want to do the dirty work massing with HTML/CSS etc.



Reasons for switching:
---------------------------

- **Mardown, HAML, bare bones HTML**. I wanted to have a bit more control over how my blog looks like.
- **Blogging software** isn't good enough. Unfortunately I haven't found yet a good **geeky** S/W for blogging.
- **Easier to write** from VIM. I just fire up my editor.

Why I didn't want to switch:
----------------------------

- Losing **PageRank**, which shuldn't really be an issue (see below).
- **Uncerteinities**. So now I have to maintain it myself? Take care of updates? Ohh, yeah!
- **Self-hosted**. Nothing to say here, never worry about hosting.

I have been on blogger since 2006 and have never ever needed to do anything to the blog in terms of mainteinance.

Switching to a self-hosted blog/site will require a bit of involvement in this regard.
But this is something I am willing to take. It's time to take my ass out of the comfy coach of Blogger.


So how to actually migrate?
--------------------------
I would split it into 2 larger steps:

1. Preparation.
2. Deployment.


Preparation
--------------------------
Here you need to setup the Octopress itself, configure it and import your existing posts from Blogger.

I won't go into details how to customise and set it up. You know where to get that information from.

I'll go directly into the migrating the Blogger posts over to Octopress.
This part is relatively simple.

What you need to do is

1. Export your Blogger posts.
2. Grab [this script](https://gist.github.com/1765496) and put it under `source` directory.
3. Run the script as below.

```bash
> cd ./source
> ruby import.rb ~/Downloads/path-to-blogger-file.xml
```

After you do this, all you'll get a bunch of the posts that are already part of your site.
Double check whether everything is correct or not. You may want to tweak the script for your needs.

Note that the script also imports the comments, but in a little ugly way.
Also you may want to disable comments before exporting the Blogger to avoid missing any comments.


Next thing you want to do is to update your Octopress RSS feed URL so that existing subscribers won't be lost.
I am using FeedBurner and I had to set `subscribe_rss: http://feeds.feedburner.com/DmitriyNagirnyak` in the `_config.yml`

Now that you've got your posts, you want to set-up the redirection from your blog to your new site.

I prepared [simple Sinatra application](https://github.com/dnagir/approache-redirects/blob/master/app.rb) for that.
You definitely want to fork and tweek it to your needs. Note that I'm not using the `blog/YYYY/MM/DD/title` format.
I just use the `blog/title` format.


Now go ahead and deploy this app. I've decided to use Heroku for that which is the simplest and easiest way to go.
But make sure you deploy to the domain of your blog. For example, mine was `blog.approache.com` and I deployed it to this domain.

It of course will not take any affect until you change your DNS settings. But you are safe to go now when you do.


Deployment
-------------------------------------------

By now you should have:

- The Octopress site ready to go (with all the posts migrated).
- Blogger redirection deployed.

Now go ahead and actually deploy your Octopress site.
I wanted to merge `blog.approache.com` into the `aproache.com` so I deployed the new site to `approache.com`
that's hosted by *Github Pages*.

Now make sure everything is working properly and you have dome everything right.
If you've missed something out, then go ahead and fix it. Then redeploy.

Repeat and rinse until happy.


When you are happy with what you have on the Octopress, the very last thing to do is to **disable the Blogger**.

You should do it simply by changing your DNS record to point to your Octopress server (often it's an `A-record`).
In my case I hade to change the DNS record from `CNAME - ghs.google.com` to `A - 207.97.227.245`

Since you've already deployed your redirection app to that domain, all the user will be automatically redirected to your new Octopress site.
All the PageRank should be preserved since the redirection is permanent.

That should be it.
Hope this is helpful for you.

