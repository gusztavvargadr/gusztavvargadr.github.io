---
layout: post
title: "#2 GitVersion to the rescue"
excerpt: Convention-based branching and versioning using GitVersion to implement GitFlow and Semantic Versioning.
tags: [ "GitVersion", "GitFlow", "Semantic Versioning", "SemVer", "Octopus Deploy", "Octopus" ]
image:
  feature: 2/feature.png
comments: true
---

{% include _toc.html %}  
<br/>
In the [previous post]({% post_url 2015-09-18-1-everyday-gitflow-and-semantic-versioning %}) about [GitFlow][GitFlow] and [Semantic Versioning][SemVer] I have outlined a configuration for convention-based version number generation and status checks through the deployment pipeline. As I mentioned there, I just came across [GitVersion][GitVersion], the awesome tool which brings this setup to the next level. Actually, given this tool's capabilities, what I described back then as an automated flow for the above tasks, feels now doing all the work manually.  
<br/>
In this post I show the configuration of this new tooling resulting in the same end result but in a much more flexible and maintainable way.  
<br/>
Based on these posts it seems that this is a blog about only GitFlow and Semantic Versioning but this is not the case. It's just that all of the posts so far are about the topic.

## Requirements

* protected branches, increment number
* show config changes from default
* Octopus Deploy channels

## Summary

[GitFlow]: http://nvie.com/posts/a-successful-git-branching-model/
[SemVer]: http://semver.org/
[GitVersion]: https://github.com/GitTools/GitVersion
