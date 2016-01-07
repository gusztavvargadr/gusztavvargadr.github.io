---
layout: post
title: "#3 ASP.NET 5 configuration for the masses"
excerpt: Introducing the ASP.NET 5 configuration system and reusing existing settings.
tags: [ "ASP.NET", "Configuration" ]
image:
  feature: 3/feature.png
comments: true
---

{% include _toc.html %}  
<br/>
[ASP.NET 5][AspNet5], being a complete redesign of the web stack from Microsoft, brings significant changes to the [configuration system][AspNet5Configuration], too. This post quickly introduces the new capabilities through the most common usage scenarios by comparing them to the previous versions and provides some easy workarounds for reusing your already existing settings.

## Core features

Let's see the new features one by one. Just reference the [core NuGet package][CoreNuGetPackage], and import the `Microsoft.Extensions.Configuration` namespace to get started.

### Configuration providers

ASP.NET 5 provides a much cleaner and more flexible way of declaring the sources of the configuration settings. Earlier, your only option was to define these values in the [classic `XML` configuration files][XML]. Machine and application or folder level settings provided some extensibility, but these options were somewhat limited.  
<br/>
Consider your settings in `JSON` like:

{% gist 4d863d7694812ca6e2a2 appSettings.json %}

You then define this as the source of your configuration:

{% gist 4d863d7694812ca6e2a2 JSONProvider.cs %}

Getting your standalone settings is as simple as:

{% gist 4d863d7694812ca6e2a2 StandaloneSettings.cs %}

Notice the use of the `:` character as the separator for the levels of the setting hierarchy. By the way, the keys used to retrieve the values are case-insensitive.  
<br/>
Of course, `JSON` is not the only option for loading your settings. Browse the [available providers][AllNuGetPackages] and reference the ones that you need, such as the `XML` file or environment variables.

{% gist 4d863d7694812ca6e2a2 MultipleProviders.cs %}

Besides the flexibility the different file formats provide, an excellent addition is supporting the abstraction for using various types of sources like environment variables or command-line parameters. This pattern provides a clear separation between defining and using the different settings via the explicit step for "building" from the sources.

### Environments

When multiple sources are set up as above, they are modeled internally as layers, in the order which they are declared when building the configuration. That is, when a setting is defined in multiple sources, the last one overwrites the previous ones.  
<br/>
As [configuration transformations][XDT] are not available, because the new system is not relying on `XML` anymore, this approach can be used to define settings for different environments effectively. Just create your baseline configuration and the differences for a given deployment.

{% gist 4d863d7694812ca6e2a2 MultipleProvidersForEnvironments.cs %}

Based on the application type, the environment itself can be identified by the [host][AspNetEnvironments] or, just like another layer of configuration, with the sources of your choice (e.g. command-line or environment variables).  
<br/>
Unfortunately, no generic mechanism exists yet for getting notified of the changes of any of the sources, but you can manually invoke `Reload()` for the already-built configuration any time.

### Complex values

One of the most powerful new features is the ability to bind to complex types. By referencing [the dedicated package][BinderNuGetPackage] you can easily load typed settings, even of those having complex hierarchies:

{% gist 4d863d7694812ca6e2a2 ComplexSettings.cs %}

This approach also supports defining default values, simply by assigning them to the type itself in the constructors, for example.  
<br/>
With the [options model][OptionsNuGetPackage], you can bring this to the next level, and use dependency injection to retrieve the settings. You can set up the related service, and then simply reference the settings you need.

{% gist 4d863d7694812ca6e2a2 ConfigureServices.cs %}

Configuration for the application itself and the related unit tests, solved.

{% gist 4d863d7694812ca6e2a2 UseOptions.cs %}

## Reusing existing settings

As expected, it is also possible to define custom configuration providers to load the settings from any alternative sources you might have. [These simple providers][Contrib] support loading settings from [Octopus Deploy][Octopus] [variables][OctopusVariables] and classic `XML` configuration files.

### Octopus Deploy variables

If you are already using Octopus for deployments, you probably also have some of your applications' settings defined as variables. This provider, which also enables some centralized configuration scenarios, can be used to load the appropriate settings scoped to the current project, environment, and machine.  
<br/>
Using one of the projects of the [demo server][OctopusDemoBlog] as a sample:  
<br/>
![Demo variables][OctopusDemoVariables]  
<br/>
Variable substitution and scoping works as expected:

{% gist 4d863d7694812ca6e2a2 OctopusSettings.cs %}

See the [Wiki][OctopusWiki] for more details.

### Classic XML configuration files

Independently of how weird it is to lock an advanced abstraction to its legacy roots, by using these providers, you can easily load your existing Web.config, app.config or other custom files to wire up the application settings and connection strings in the new system.  
<br/>
The settings are equivalent with the `JSON` format above:

{% gist 4d863d7694812ca6e2a2 app.config %}

The values are loaded as follows:

{% gist 4d863d7694812ca6e2a2 XmlSettings.cs %}

See the [Wiki][XMLWiki] for more details.

## Summary

As described above, the new configuration system provides a clean, lightweight, and easily extensible framework for working with settings. Through custom providers, you can support centralized configuration scenarios and an alternative approach for [managing secrets][AspNet5Secrets] safely.

## Resources

* [ASP.NET 5 Configuration][AspNet5Configuration]

[AspNet5]: https://docs.asp.net/en/latest/
[AspNet5Configuration]: https://docs.asp.net/en/latest/fundamentals/configuration.html
[CoreNuGetPackage]: https://www.nuget.org/packages/Microsoft.Extensions.Configuration/
[XML]: https://msdn.microsoft.com/en-us/library/1xtk877y(v=vs.110).aspx
[AllNuGetPackages]: https://www.nuget.org/packages?q=Microsoft.Extensions.Configuration
[XDT]: https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx
[AspNetEnvironments]: https://docs.asp.net/en/latest/fundamentals/environments.html
[BinderNuGetPackage]: https://www.nuget.org/packages/Microsoft.Extensions.Configuration.Binder/
[OptionsNuGetPackage]: https://www.nuget.org/packages/Microsoft.Extensions.OptionsModel/
[Contrib]: https://github.com/gusztavvargadr/aspnet-Configuration.Contrib
[Octopus]: https://octopus.com/
[OctopusVariables]: http://docs.octopusdeploy.com/display/OD/Variables
[OctopusWiki]: https://github.com/gusztavvargadr/aspnet-Configuration.Contrib/wiki/Octopus-Deploy-variables
[OctopusDemoBlog]: https://octopus.com/blog/demo-server
[OctopusDemoVariables]: {{ site.url }}/images/3/OctopusDeployVariables.png
[XMLWiki]: https://github.com/gusztavvargadr/aspnet-Configuration.Contrib/wiki/Classic-XML-configuration-files
[AspNet5Secrets]: https://docs.asp.net/en/latest/security/app-secrets.html
