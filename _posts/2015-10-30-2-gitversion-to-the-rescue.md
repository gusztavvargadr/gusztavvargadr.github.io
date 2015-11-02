---
layout: post
title: "#2 GitVersion to the rescue"
excerpt: Convention-based branching and versioning using GitVersion to implement GitFlow and Semantic Versioning.
tags: [ "GitVersion", "GitFlow", "Semantic Versioning", "SemVer" ]
image:
  feature: 2/feature.png
comments: true
---

{% include _toc.html %}  
<br/>
In the [previous post][Post1] about [GitFlow][GitFlow] and [Semantic Versioning][SemVer], I have outlined a configuration for convention-based version number generation and status checks through the deployment pipeline. As I have mentioned there, I just came across [GitVersion][GitVersion], the awesome tool that brings this setup to the next level.

Actually, given this tool's capabilities, what I have described earlier as an automated flow for the above tasks now feels like doing all the work manually.  
<br/>
In this post, I show a configuration using this new tooling, producing the same result; however, it was  achieved in a much more flexible and maintainable way.  
<br/>
Based on these posts, it seems that this is a blog about GitFlow and Semantic Versioning only, but this is not the case. It's just that all of the posts are about that topic so far.

## Requirements

The exact list of requirements is covered [in detail][Post1Branches] in the earlier post, but here is a short excerpt. Given a sample list of GitFlow-based steps, we expect the following version numbers for our [NuGet][NuGet] package artifacts:

Task | Branch | CI build number | NuGet package version
:--- | :--- | :--- | :---
Implement feature #1 | feature-1 | 1 | 1.2.0-a1feature1
Implement feature #2 | feature-2 | 2 | 1.2.0-a2feature2
Implement feature #1 | feature-1 | 3 | 1.2.0-a3feature1
Complete feature #1 | develop | 4 | 1.2.0-b4
Complete feature #2 | develop | 5 | 1.2.0-b5
Stabilize release | release-1.2.0 | 6 | 1.2.0-r6
Release to production | master | 7 | 1.2.0
Fix production issue | hotfix-1.2.1 | 8 | 1.2.1-r8
Release to production | master | 9 | 1.2.1

Using this pattern, we encode the type of the release in the version number, and we also have the natural order of "strength" of the artifacts as we go through the process of developing a feature from the first commit to deploying to production.

## Implementation with GitVersion

I have set up a [sample project][SampleProject] to demonstrate the evolution of the resulting artifacts along the workflow. It is a simple [ASP.NET Web API][AspNetWebApi] host exposing endpoints to work with, well, "[values][SampleProjectValues]", with the main purpose of having something simple enough to be able to focus on the high-level steps in the workflow instead of the actual "features".  
<br/>
As we focus mainly on versioning here, there is no actual deployment happening. Instead, the concepts are modeled by creating a deployment NuGet package for [Octopus Deploy][OctopusDeploy] as the CI build artifact, and the deployment itself remains "just" an implementation detail.

### Basics

I used custom CI build scripts earlier to set up the above versioning pattern based on the CI build number, the current branch, and some implicit rules derived from GitFlow. It is exactly what GitVersion masters, in a highly configurable way, resulting in a much more flexible solution than encoding custom rules in custom scripts.  
<br/>
It supports a [command line][GitVersionCommandLine] executable and an [MSBuild][GitVersionMSBuild] task also to do its magic as part of the build process. For the purpose of setting up this configuration, I have chosen the command line version because just invoking it outside the context of a build was much more comfortable for some debugging scenarios. As soon as the solution gets more stable, the "regular"  build integration might be a better option.

### Configuration

After installing it, and invoking the command line executable by typing `gitversion` inside a folder containing the clone of a Git repository, GitVersion dumps out a list of variables containing the calculated version numbers for different purposes. The result below is what it shows [at the time of this writing][SampleProject240] for the sample project above.

{% gist 6b6c98412f4b9ed40f04 Variables.json %}

The values are [determined][GitVersionSources] by the current branch and the commits since the latest base version (based on like tags and version numbers in branch names) and, of course, GitVersion's configuration defining, for example, the version increment policies for the different branches. By default, it is set up for GitFlow, as we can check by executing `gitversion /showconfig`:

{% gist 6b6c98412f4b9ed40f04 ShowConfig.Default.yaml %}

The various global or branch-level [configuration options][GitVersionConfiguration] can then be customized according to our needs by creating the `GitVersionConfig.yaml` file and specifying the differences:

{% gist 6b6c98412f4b9ed40f04 GitVersionConfig.yaml %}

In this setup, I have applied the `ContinuousDeployment` mode and the custom assembly informational version formatting globally, resulting in a (NuGet) version number that differs for every commit and can be used as the input for Octopus Deploy's [packaging tool][OctoPack] without any further configuration, fully supporting continuous deployment.  
<br/>
The custom `tag` values set up the prefixes for the prerelease version number extensions as described above. The only exception here is the configuration of feature branches; for that, currently, we need the hack of starting their names with the letter `a` to support the desired version order.  
<br/>
We can make sure that the settings are applied as expected by executing `gitversion /showconfig` again so our settings merge with the defaults:

{% gist 6b6c98412f4b9ed40f04 ShowConfig.Custom.yaml %}

### Usage

GitVersion comes with out-of-the-box support for the major CI build providers, that is, it automatically recognizes its execution context and reads (like the current branch) and writes (like the CI build number) specific settings accordingly. The following is the [AppVeyor][AppVeyor] configuration for the above sample project:

{% gist 6b6c98412f4b9ed40f04 appveyor.yml %}

I have set up here logging to the console and writing output in the format specific to the CI build environment. Also, I have specified our custom file that stores the assembly version metadata and the branch name to make sure the correct one is used when like a branch is opened and pushed without any further commits yet.  
<br/>
After a couple of steps of improving the support for "working with values" in the sample project, we get the following version numbers:

Task | Branch | Semantic version | NuGet version
:--- | :--- | :--- | :---
Implement feature #1 | feature/a-refactor-value-naming | 2.3.0-a-refactor-value-naming.1 | 2.3.0-a-refactor-value0001
Implement feature #2 | feature/a-update-documentation | 2.3.0-a-update-documentation.1 | 2.3.0-a-update-documen0001
Implement feature #1 | feature/a-refactor-value-naming | 2.3.0-a-refactor-value-naming.2 | 2.3.0-a-refactor-value0002
Complete feature #1 | develop | 2.3.0-b.3 | 2.3.0-b0003
Complete feature #2 | develop | 2.3.0-b.7 | 2.3.0-b0007
Stabilize release | release-2.3.0 | 2.3.0-rc.0 | 2.3.0-rc0000
Release to production | master | 2.3.0 | 2.3.0
Fix production issue | hotfix-2.3.1 | 2.3.1-rc.1 | 2.3.1-rc0001
Release to production | master | 2.3.1 | 2.3.1

The prerelease tag prefixes are slightly different from the above requirements, but the same package order is still maintained. We no longer rely on internal build numbers of the CI environment, but use GitVersion's commit counter instead. We just use the semantic version number as the build number too.  
<br/>
The above table shows only a part of the actual builds; you can check the [history][SampleProjectBuildHistory], including the detailed logs of GitVersion's internal working, for more information.

## Extras

Besides relying now only on configuration, instead of writing custom scripts for handling version numbers, we gain the following extras also by using GitVersion.

### Status checks

I am a huge fan of [GitHub][GitHub]'s recently introduced [protected branches][GitHubProtectedBranches] feature. With the related required status checks, we can prevent propagating the required artifacts through the deployment pipeline by simply blocking creating the release itself. For this to work effectively, it seems to make sense to turn on the branch protection for every branch except the feature branches.  
<br/>
Manually maintaining a base version in this setup, though, requires usually new feature branches just for bumping the version number that feels to have a clear smell that something is wrong. Again, GitVersion solves this problem by resolving the base version based on the repository objects we already have, anyway.

### Deployment

Now it feels natural that Octopus Deploy has just (pre)released supporting customizing deployment processes based on branching and versioning patterns. Its long-awaited [Channels][OctopusDeployChannels] feature eliminates the need for custom processes or scripts based on the type of a release. I look forward to this feature being available in the next stable release and further simplifying our continuous deployment workflow with it.

## Summary

I hope this post will help you to give GitVersion a try, in case you were unfamiliar with it before. Even if your workflow differs significantly from the one described above, I encourage you to play with it, as it natively supports all the major branching models as well as the CI build providers, and through its extensive configuration options, the possible use cases are basically endless. Share your experiences in the comments.  
<br/>
I am also glad that the recent new features for tooling are signs that at least some of us are getting closer to having an unofficial consensus on branching and release management. In case you still miss some features, create and issue or send them a pull request, as probably I will also report on the [minor problems][SampleProjectIssues] I have discovered so far.

## Resources

* [GitVersion][GitVersion]
* [GitFlow][GitFlow]
* [Semantic Versioning][SemVer]
* [Octopus Deploy][OctopusDeploy]
* [AppVeyor][AppVeyor]

[Post1]: {% post_url 2015-09-18-1-everyday-gitflow-and-semantic-versioning %}
[GitFlow]: http://nvie.com/posts/a-successful-git-branching-model/
[SemVer]: http://semver.org/
[GitVersion]: https://github.com/GitTools/GitVersion
[Post1Branches]: {% post_url 2015-09-18-1-everyday-gitflow-and-semantic-versioning %}#branches-and-releases
[NuGet]: https://www.nuget.org/
[SampleProject]: https://github.com/gusztavvargadr/GitTools-GitVersion.Samples
[AspNetWebApi]: http://www.asp.net/web-api
[SampleProjectValues]: https://github.com/gusztavvargadr/GitTools-GitVersion.Samples/blob/de432b6698788a3256290bdcea1efeeb27e5acc3/sources/Host/Controllers/V1/ValuesController.cs
[OctopusDeploy]: https://octopus.com/
[GitVersionCommandLine]: http://gitversion.readthedocs.org/en/latest/usage/command-line/
[GitVersionMSBuild]: http://gitversion.readthedocs.org/en/latest/usage/msbuild-task/
[SampleProject240]: https://github.com/gusztavvargadr/GitTools-GitVersion.Samples/tree/729510dc22672fc5850281901696ead45856a27e
[GitVersionSources]: http://gitversion.readthedocs.org/en/latest/more-info/version-sources/
[GitVersionConfiguration]: http://gitversion.readthedocs.org/en/latest/configuration/
[OctoPack]: http://docs.octopusdeploy.com/display/OD/Using+OctoPack
[AppVeyor]: http://www.appveyor.com/
[SampleProjectBuildHistory]: https://ci.appveyor.com/project/gusztavvargadr/gittools-gitversion-samples/history
[GitHub]: https://github.com/
[GitHubProtectedBranches]: https://github.com/blog/2051-protected-branches-and-required-status-checks
[OctopusDeployChannels]: https://octopus.com/blog/channels-walkthrough
[SampleProjectIssues]: https://github.com/gusztavvargadr/GitTools-GitVersion.Samples/issues
