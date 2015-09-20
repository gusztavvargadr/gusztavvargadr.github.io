---
layout: post
title: "#1 Everyday GitFlow and Semantic Versioning"
modified:
categories: 
excerpt: Practical use of branching and versioning strategies for release management.
tags: []
image:
  feature: 1/feature.png
date: 2015-09-20T11:38:19+02:00
comments: true
---

{% include _toc.html %}

While I'm using both [GitFlow][GitFlow] and [Semantic Versioning][SemVer] for a long time now, I always felt that something is missing during the everyday workflow. They are both nice concepts but offering solutions for problems of different domains, still, applying them together seems to be a bit more complicated than it feels it should be.  
<br/>
It might also mean of course that the workflow itself I try to apply it to is not optimal, but that can be a topic for a different post later. In this one, I just describe one simple approach for managing the release of applications and other shared components.

## The problem

How do we make sure that an application release never gets to production without passing the integration tests? How do we make sure that a class library NuGet package never gets published to a public feed without passing the static code analysis requirements?  
<br/>
Most of the tools we need for these are already there, and we are already using them "manually". What's missing is some more automation but to achieve that we also need some conventions and patterns.

## The toolkit

Let's see in a bit more detail what we already have.

### Environments

Unless we meet the requirements or the infrastructure for testing in production a classic approach is using [different environments][DTAP] for different stages of the deployment pipeline like integration testing or user acceptance. What we need to make sure is that a specific version can be deployed only to the environments it is allowed to. For this, we need first the unique identification of each version.

### Semantic Versioning

Before going into the details of what exactly we need to version, we have to think about how to do versioning at all. This topic is not new and, fortunately, we have Semantic Versioning which is obviously versioned also conforming to itself as you can double check reading through the [specification][SemVer].  
<br/>
A nice extra in the .NET world that NuGet itself [almost supports it][NuGetSemVer] as does [most of the public packages][Log4Net2]. At least you have an option here.

### GitFlow

For most of the projects I have worked with GitFlow always felt to be the first natural choice to go with. In case it turns out to be too complex given the frequency of changes or the level of collaboration you can "fall back" to e.g. [GitHub Flow][GitHubFlow] where everything is "just" a hotfix.  
<br/>
I would like to add though that for this setup you don't even need Git as the ALM Rangers also [describe][ARBranching], it is just easier to implement with it than for example Subversion.  
<br/>
I will not go into the details of the various branching strategies themselves as their documentation is already the [best][GitFlow] [what][GitHubFlow] [we can have][ARBranching].

## A method to forget

In the good old days before the tools mentioned above were available or were just ignored a common approach was to build a version once and propagate the same artifacts across the different environments. A basic solution for this was committing the actual binaries to a dedicated repository and propagating them through a custom set of branches reflecting the actual environments. This involved sometimes baseless merges and a lot of merge conflicts in mainly configuration files. All you needed after this was some custom script on top of Robocopy to make the actual deployment.  
<br/>
This setup is very error-prone due to a lot of manual steps required, and because things could go wrong easily, they usually did. Please forget this approach and everything you read in the previous paragraph.

## The next approach

Let's see now a possible use of the above concepts and the related tooling.

### Artifacts

For identification, we version various (CI build) artifacts like deployment and shared component packages. A basic requirement is to link to the source of the change (in this case a Git commit hash) and to the process which creates it (the CI build identifier). This is a fairly straightforward setup in most CI tools using the internal build counter.  
<br/>
For shared components, NuGet is there for the rescue and using a deployment manager like [Octopus Deploy][Octopus] enables the use of the same concept for all these deliverables. But how do we construct and apply the required metadata exactly?

### Branches and releases

Instead of creating dedicated branches for environments let's create artifacts which describe their stage in the deployment pipeline so naturally link to the environment they need to be deployed to. Based on the convention of what the environment is basically used for we can use this to automatically identify the next step in the workflow too.  
<br/>
We have to define first the how "stable" an artifact built from a given branch is:  

Branch | Release type | Version format
:--- | :--- | :---
feature | alpha | #major.#minor.#revision-a#build#feature
develop | beta | #major.#minor.#revision-b#build
release | release candidate | #major.#minor.#revision-r#build
hotfix | release candidate | #major.#minor.#revision-r#build
master | stable | #major.#minor.#revision

Based on these formats we set up the [assembly metadata][AssemblyVersions] e.g. through a shared source file across all the projects as follows.  
<br/>
`[assembly: AssemblyVersion("#major.#minor")]`  
`[assembly: AssemblyFileVersion("#major.#minor.#revision.#build")]`  
`[assembly: AssemblyInformationalVersion("#major.#minor.#revision-<prerelease tag>")]`  
<br/>
For `AssemblyInformationalVersion`, we use exactly the same format as defined in the table above. This setup provides the version numbers as expected according to [Semantic Versioning][SemVer] for the runtime itself, the CI build identification and the resulting artifacts' package version.  
<br/>
Given some sample [GitFlow][GitFlow]-based steps our NuGet packages will have the following versions after a CI build being trigger on commits:

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

This reflects the natural order of "strength" of releases when sorting packages by version. When I need to bump the version number I prefer incrementing it manually on release and hotfix creation in the shared metadata file and committing it to the repository so it propagates through merging as everything else and I will always have the correct actual values for the local clones too.

### Deployments

As the first line of defense for making sure we do not accidentally deploy packages to "wrong" environments is to actually block creating the packages themselves. Besides the regular techniques like failing the whole CI build when unit tests fail we can utilize e.g. [protected branches][GitHubProtectedBranches].  
<br/>
Using the concept of [lifecycles][OctopusLifecycles] in [Octopus Deploy][Octopus] we can control the propagation of an actual release through the different environments. In the above flow, however, we have different artifacts and so new releases for the various stages so what we actually need is controlling where a release can enter the deployment pipeline:

Release type | Allowed environments
:--- | :---
alpha | D
beta | T, D
release candidate | A, T, D
stable | P, A, T, D

This check can be enforced via e.g. a custom script until something similar is natively supported in a form of like version based multiple lifecycle types for a project. Through encoding the release type information into the package version we have the foundation now to the "safe" and automatic release creation and deployment using either [Octopus Deploy][Octopus] [natively][OctopusAutomaticRelease] or for example deployment trains based on a predefined schedule.

## Alternatives

Having the same release number as the deployment package itself (actually not separating the concept of a release properly) is still a bit smelly here. Especially for NuGet packages of class libraries some sort of additional release naming scheme based on e.g. tagging (which is recommended to use anyway at least for stable releases) can be a nice improvement. I have just came across that [GitVersion][GitVersion] supports these types of conventions natively in a highly customizable way so this tool definitely worth taking a look at.

## Summary

In this post we have seen a simple approach for managing the release of applications and other shared components and hopefully some parts might be useful for you in one way or another.  
<br/>
Add your comments below about the setup above or on how you do branching, versioning and release management in general.

## References

* [GitFlow][GitFlow]
* [GitHub Flow][GitHubFlow]
* [ALM Rangers Branching Guidance][ARBranching]
* [Semantic Versioning][SemVer]
* [DTAP environments][DTAP]
* [NuGet versioning][NuGetSemVer]
* [log4net versioning][Log4Net2]
* [Assembly version numbers][AssemblyVersions]
* [Octopus Deploy][Octopus]
* [Octopus Deploy Lifecycles][OctopusLifecycles]
* [GitHub protected branches][GitHubProtectedBranches]
* [GitVersion][GitVersion]

[GitFlow]: http://nvie.com/posts/a-successful-git-branching-model/
[SemVer]: http://semver.org/
[DTAP]: https://en.wikipedia.org/wiki/Development,_testing,_acceptance_and_production
[NuGetSemVer]: https://docs.nuget.org/create/versioning#really-brief-introduction-to-semver
[Log4Net2]: https://www.nuget.org/packages/log4net/
[GitHubFlow]: https://guides.github.com/introduction/flow/
[ARBranching]: https://vsarbranchingguide.codeplex.com/
[Octopus]: https://octopusdeploy.com/
[AssemblyVersions]: http://stackoverflow.com/questions/64602/what-are-differences-between-assemblyversion-assemblyfileversion-and-assemblyin
[GitHubProtectedBranches]: https://help.github.com/articles/about-protected-branches/
[OctopusLifecycles]: http://docs.octopusdeploy.com/display/OD/Lifecycles
[OctopusAutomaticRelease]: http://docs.octopusdeploy.com/display/OD/Automatic+Release+Creation
[GitVersion]: https://github.com/GitTools/GitVersion