+++
date = '2026-08-17T22:52:16+03:00'
draft = false
title = 'Transitions in My Life and This Blog'
description = "A summary on the last month's life updates and a bit of commentary on what's to happen in the next few"
tags = ["Journalistic Writing"]
showToc = false

[cover]
image = ""
alt = "Descriptive alt text"
caption = "Optional caption text"
relative = false
hidden = false
+++

It's been a second since I've written here. The summer has so far been uneventful but a much needed time to recover from what has been a rather busy [Bachelor's](/posts/bachelors) degree. I had a chance to sort out everything that I've been putting off. My phone is now clean, the archive is sorted, health problems are actively dealt with. The future is looking quite bright too! I've recently been accepted into the *MSc in Computer Engineering* program at *Bilkent University* where I will be studying applied cryptography under the supervision of [Prof. Abdullah Talayhan](https://www.abdullahtalayhan.com/) in [KAFESLAB](https://kafes.cs.bilkent.edu.tr/). I'm quite excited about what's to come out of this, as the general reading I've done so far about the subject has been very interesting. In fact, in a way, I ended up in the part of computer science that I would have wanted to research since my childhood. I've always been into this whole computer thing, and around middle school I really got into mathematics, and applied cryptography is a healthy middle-ground between the two. It offers both proofs and algorithms and that's what I want out of my research.

Unrelated, I've once again changed my blog setup. This time, I moved away from the self-hosted Apache Web Server and to *GitHub Pages*. I was putting this off for a while because I assumed I would have to tinker with GitHub Actions to get the Hugo compilation and hosting to work. Apparently, there is a template that works after a one line change. So now, the upload script mentioned [here](/posts/how)[^1] is obsolete. Now I have to trust GitHub Actions to *be up*, which is apparently [finnicky](https://www.bleepingcomputer.com/news/microsoft/microsoft-confirms-github-is-down-worldwide/) :p You can now check the *complete* source code of this website on the [repository](https://github.com/erengokirmak/erengokirmak.github.io), as I'm not using any secret environment variables anymore.

The next two years, containing my MSc studies, will probably be quite eventful as I read through papers and gain more knowledge into cryptography. I will most likely be using this blog more, posting about my journey and the things I see. In general, what I want to use this blog for the foreseeable future is to make it an archive of my progress. Hopefully it will prove useful to someone else in the future too :) 

[^1]: Side note, the old build-and-upload script was giving me problems because the version of PaperMod I'm currently using has a deprecation issue on the `.Language` section of the configuration. The `--panicOnWarning` flag was not allowing compilation. In case someone comes across this problem, removing the flag solves it.