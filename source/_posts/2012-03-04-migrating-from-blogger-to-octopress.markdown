---
layout: post
title: "Migrating from Blogger to Octopress"
date: 2012-03-04 20:09
comments: true
categories: DevTools, Ruby, Web
---


I've been a Blogger user since 2006 and decided to switch over to something more geeky.

This post will cover some of the reasons for that and also will provide an overview
of how to migrate from Blogger to Octopress.

What do I want to achieve?
----------------------------

- **Merging** my personal site and blog - those were totally separate, unrelated entities, not good enough.
- Write **more often**, using the same tools I use on a daily basis (Vim ATM).
- More **hands-on** kind of blogging, I actually do want to do the dirty work messing with HTML/CSS etc.



Reasons for switching:
---------------------------

- **Markdown, HAML, bare bones HTML**. I wanted to have a bit more control over how my blog looks like.
- **Blogging software** isn't good enough. Unfortunately I haven't found yet a good **geeky** S/W for blogging.
- **Easier to write** from Vim. Writing is much easier, not moving my hands off the keyboard and staying in the terminal.
- **Version controlled**. Nice to have, but not crucial for me.

Why I didn't want to switch:
----------------------------

- Losing **PageRank**, which shuldn't really be an issue (see below).
- **Uncerteinities**. So now I have to maintain it myself? Take care of updates? Ohh, yeah!
- **Self-hosted**. Nothing to say here.
- I have never ever needed to do anything with the blog in terms of mainteinance while being on Blogger. I really just worked.

Switching to a self-hosted blog/site will require a bit of involvement from me.
But this is something I am willing to take. It's time to take my ass out of the comfy couch of Blogger.


So how to actually migrate?
--------------------------
I would split it into 2 larger steps:

1. Preparation.
2. Deployment.
3. Finalisation.


Preparation
--------------------------
At this stage you need to [setup the Octopress itself](http://octopress.org/docs/setup), [configure](http://octopress.org/docs/configuring) it and import your existing posts from Blogger.

I won't go into details how to [customise](http://octopress.org/docs/theme) and set it up, you see the links.

I'll go directly into the migrating the Blogger posts over to Octopress.

What you need to do is

1. Export your Blogger posts.
2. Use [this script](https://gist.github.com/1765496) to import it into Octopress.

After you do this, all you'll get a bunch of posts that are already part of your site.
Double check whether everything is correct or not. You may want to tweak the script for your needs.

*Note* that the script also imports the comments, but in a little ugly way.
(*TIP*, you may want to disable commenting before exporting the posts from Blogger).


Next thing you want to do is to update your Octopress RSS feed URL so that existing subscribers won't be lost.
I am using FeedBurner and I had to set `subscribe_rss: http://feeds.feedburner.com/DmitriyNagirnyak` in the `_config.yml`

Now that you've got your posts, you want to set-up the redirection from your blog to your new site.

I prepared [simple Sinatra application](https://github.com/dnagir/approache-redirects/blob/master/app.rb) for that.
You definitely want to fork and tweek it to your needs. Note that I'm not using the `blog/YYYY/MM/DD/title` format.
I just use the `blog/title` format.

Now go ahead and deploy this app. I've decided to use Heroku for that which is the simplest and easiest way to go.

But **make sure you deploy to the domain of your blog**. For example, my Blogger blog was hosted on the `blog.approache.com` and I deployed it to this domain.

It of course will not take any affect until you change your DNS settings.
But this will enable permanent redirects immediatly when you'll do that (thus preserving all your old links).


Deployment
-------------------------------------------

By now you should have:

- The Octopress site ready to go (with all the posts migrated).
- Blogger redirection deployed.

It's time to go ahead and actually [deploy](http://octopress.org/docs/deploying) your Octopress site.

I wanted to merge `blog.approache.com` into the `aproache.com` so I deployed the new site to `approache.com`
(hosted on *Github Pages*).

Now make sure everything is working properly and you have dome everything right.
If you've missed something out, then go ahead and fix it. Then redeploy.

This may take a couple of iterations to get it right.

The point here is that you basically now have 2 blogs - one is the old Blogger, the other - the Octopress.
You can experiment with the Octopress here, but don't do it for too long (I would say max of 1 day).

After you're happy with the new site and blog it's time to finalise everything.

Finalisation
---------------------------------------------

Next step is to make sure your subscribers will still receive updates through the FeedBurner.
For that:

1. Sign in into FeedBurner.
2. Replace the original feed URL by the Octopress' one (which is something like `http://ApproachE.com/atom.xml`).


By now you should be ready to switch your your Blogger domain to your main site.

You probably will do it simply by changing your DNS record to point to your Octopress server.
In my case I had to change the DNS record from `blog - CNAME - ghs.google.com` to `. - A - 207.97.227.245` (dot means top-level domain here).

Since you've already deployed your redirection app, all the old links will still work.
All the PageRank should be preserved.

The very last thing to do is to **disable the Blogger** if you want to.

Summary
----------------------------------------------

Switching to Octopress was relatively painless thanks to Blogger's ability to export posts and the script that could import it into Octopress.

Preserving URL was relatively easy too and the rest was left to FeedBurner and DNS hosting.


Hope this is helpful for you.

