---
layout: post
title: "Increase your productivity in Vim and Terminal"
date: 2012-03-12 06:30
comments: true
categories:
  - Productivity
  - DevTools
  - Vim
  - Linux
---

This post will give you *minimal* suggestions that
you can apply in your daily work to immediately increase your productivity.

I'm writing this after watching the [Steve Klabnik's screencast](http://blog.steveklabnik.com/posts/2012-02-22-two-pomodoros)
where he is working *"in a wild"*.

I love this idea and have done videoing 
how I work on a little [ios-checkboxes](http://approache.com/blog/rails-plugin-with-tested-assets/)
and [knockout-rails](http://approache.com/blog/knockoutjs-validations-video/).

The world would an awesome place if more people (yes, including **you**) would start sharing the way they work.
Well done Steve!

But today I want to focus on just a few of things that should dramatically improve the productivity.

<!-- more -->

Vim productivity
===================================


{% blockquote Biju Chacko, Vim Quotes %}
Vim is one of a select bunch of tools for which I have no substitute.
It is a brilliant piece of work!
{% endblockquote %}

The power of vim is huge. Very small number of people actually do know how to use most of it.
I'm certainly not one of them.

But let me suggest some of the things that keep myself more productive:

Remap your CapsLock key to Control
------------------------------------
*Why?* Because the *Control* key is located extremely inconveniently
while *CapsLock* is right under your baby-finger. All the time.

*How?* Follow [this guide](http://www.manicai.net/comp/swap-caps-ctrl.html).

I blindly trusted the *command* given by [Garry Bernhard](http://twitter.com/garybernhardt)
in his [DestroyAllSoftware - Some Vim Tips](http://www.destroyallsoftware.com/screencasts/catalog/some-vim-tips)
on this. Never regretted.

Don't think about it. Just do it and I'm sure you won't go back.



Use Vim jumps
---------------------------------
*Why?* A lot of times you need to jump forth and back between 2 place or go to where you've been a minute ago.
A log of people just find that line/file again. It's a waste of time.

*How?*

- `Ctrl-o` and `Ctrl-i` to go to the previous/next location you jumped to.
- ` `` ` (two backticks) - jump back to where you were.
- `gi` - go to the last place you inserted a text.


Use appropriate Vim navigations
---------------------------------
*Why?* Typing `l` (move right one symbol) or similar multiple times is waste of time.

*How?*

- `{` and `}` - jump *paragraph* back and forth.
- `Ctrl-F/B` - move one *screen* back and forth.
- `Ctrl-E/Y` - *scroll* the screen.
- `*` (star) - search for the word under cursor, then `n/p` to jump to next/previous.
- add `imap jj <Esc>` to your `.vimrc` and don't use `Esc` anymore.

Changing case and repeating a command
------------------------------------
*Why?* Because a lot of things can be done much more efficiently.

*How?*

- `~` (tilde) - toggle the casing of a letter/selection (upper-case/down-case).
- `.` (dot) - repeat the last set of commands (use in a combination with search, such as `*`, and jumps).

Temporarily map commands you run
---------------------------------------
*Why?* Because you don't want to type the same command over and over again.

*How?* One example is `nmap <leader>s :! bundle exec rspec % --colour --focus<cr>`.
This will run the current spec file when you press `,s` (in my case).

**Rule of thumb**: if you do something more then twice in the terminal outside of Vim, map it using `nmap`.
Don't switch windows, *don't lose your context*.



Terminal productivity
======================================

Just a couple of things here.

Use iTerm2
-----------------------------------
*Why?* At least because you can split window without losing the context.

*How?* Install it from the [iterm2.com](http://www.iterm2.com/) site (or even use tmux!).

Use `Ctrl-D/Ctrl-Shift-D` (while in Vim or any iTerm tab/window) to split the current terminal window opening a new shell but still being able to see what you are currently working on.


Use `!!` (double bang) or arrow up
--------------------------------------
*Why?* Because it repeats the previous command that you should have mapped in Vim but didn't.

*How?* Just type `!!` and it will execute last command.
This is simple, but strangely enough I can see people are actually retyping commands.


Enable Vim mode in bash
------------------------------------------
*Why?* Because you navigate in the terminal too. And Vim mode makes it seamless.

*How*? [Create an inputrc file](http://linuxart.com/log/archives/2005/10/13/super-useful-inputrc/) and
add `set editing-mode vi` to it.




Useful links
===================================


- [Vim anti-patterns](http://blog.sanctum.geek.nz/vim-anti-patterns/) - must-read if you want to be better at Vim.
- [Smash into Vim](http://peepcode.com/products/smash-into-vim-i) - always awesome PeepCode series on Vim.
- [Vim for Rails developers](https://workshops.thoughtbot.com/vim) - nice overview of the plug-ins and more productive use of Vim.
- [Meet the Command Line](http://peepcode.com/products/meet-the-command-line) and [Advanced Command Line](http://peepcode.com/products/advanced-command-line) - great screencasts if you want to get better with command line.
- [DestroyAllSoftware screencasts](http://www.destroyallsoftware.com) - screencasts covering Vim, Unix, Ruby.

The DestroyAllSoftware stands out here because Gary covers range of extremely focused, professional topics that you can't ignore.

Hope this post will help you to leverage your tools a bit better and will teach you a thing or two.
