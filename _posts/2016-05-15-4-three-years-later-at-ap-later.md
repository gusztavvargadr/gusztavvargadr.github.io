---
layout: post
title: "#4 Three years later at AP-later"
excerpt: Summary of my three years at Albumprinter.
tags: [ "Albumprinter" ]
image:
  feature: 4/feature.jpg
comments: true
redirect_to: https://blog.gusztavvargadr.me/4-three-years-later-at-ap-later-e3c1d0be3f96
---

{% include _toc.html %}  
<br/>
It's been a while since my last post. It's not that I haven't been busy with experiments and prototypes worth sharing, it's rather that I've been too busy to share them - at least that was the excuse I found for myself.  
<br/>
We have some hard deadlines at [Albumprinter], my current employer, so while focusing on those projects, I kept postponing writing new posts for my blog. I've just had my three year anniversary there and since most of my experiments are more or less related to "regular work", I though it might make sense to write a summary of my experiences so far.  
<br/>
I am now focusing on tackling [being busy][Busy] in general (represented by [The Scream][TheScream] above), and as part of that, setting up metrics and alerts for myself to provide early warnings when things are about to get out of control (such as now). As a critical metric, I'll monitor the frequency of new posts on this blog, so expect some more topics soon and at a more solid pace. To achieve that, hopefully, I'll find the time first that is required to take a step back, but writing this down is already a good sign in itself.

## Entering Albumprinter

So let's get back to "work". This is of course not the only possible way or not even an optimal one to get it done, but here are the steps I took to get to Albumprinter.

* Be born and raised in [Hungary]. Focus on the abstract and spend some time in IT.
* Have a girlfriend who is about to lose her job due to her employer reorganizing and centralizing, moving departments from all over Europe to [Amsterdam], the [Netherlands].
* Decide together in three days that she should apply for a position at her department at the new location.
* Quit everything and follow her when she gets the job.
* Move to the Netherlands in the winter, but do some work remotely for your last employer in Hungary, so you don't go crazy while watching people parking their cars in the rain for months, all this in grayscale.
* Get a few job offers and reject them all, even if they have better benefits, in favor for Albumprinter, as you know from the first moment that this is the place to work at.

![Entering Albumprinter][EnteringAlbumprinterImage]  
<br/>
How do you know you've found that place? You just feel it. People's attitude during the interviews, but the overall atmosphere just reflects it. Being close to [Centraal Station][CentraalStation] and having an [awesome lunch][DutchLunch] are relative anyway.

## Early days

Moving to another country is quite stressful in itself, even if it's still in Europe (on the same continent, not necessarily the same "Europe"), and in our case, the same [time zone][CET]; and, there are a lot of tiny differences. It's much more than that the sun rises and sets at weird times. You get used to it very quickly, though, as you realize soon that these little differences add up to something much more livable. You accept (and after a while, expect) the new environment as the new standard, and the differences become much more shocking when you return to where you came from, even if only for a couple of days.  
<br/>
In my experience, generally, in Hungary people are much more stressed and depressed. I think it's a result of [our history][SomeFactAboutHungary], which is now part of our nationality somehow, which is further emphasized by some people's living conditions. We never really give up, but also, we don't expect too much. This results in anger, and yelling at each other is quite common in the workplace, and, unfortunately, at home too.  
<br/>
So, when starting working at Albumprinter, I was expecting the same, and it just did not happen. I did not understand why they did not yell at me because I probably made some mistakes or chose some sub-optimal solutions during the learning phase and since then, too. After a while, on purely a statistical basis, based on my former experience, I was expecting a [yelling-only day][ChainOfScreaming] or simply that I will be just fired for this and that. The turning point, when I realized it will never happen, arrived in two stages.  
<br/>
First, one of my emails starting with the standard line about being sorry for the stupid question was answered with stating that there's no such thing as a stupid question. And it was in a way that I knew they meant it.  
<br/>
Shortly after this, following one of our regular stand-up meetings, someone sent around an email apologizing for raising his voice during the meeting. I was quite surprised as I did not even notice it happened, as it did not hit my usual threshold of someone raising his voice.  
<br/>
After a couple of months at Albumprinter, I was now quite sure that I've found a workplace where I can start focusing on building something great.  
<br/>
![Early days][EarlyDaysImage]  
<br/>
I cannot emphasize enough the importance of people smiling and being friendly and open to new ideas and discussions all the time. It yields such a great boost to morale and productivity that no one can afford not to have this. This behavior being the norm - not just in the workplace, but on the scale of a whole country - is sometimes still unbelievable to me. Again, people's attitude is probably an indicator of how well things are going in general, but at least we have an indicator. It can be more complicated to quantify than [GDP], but it is also harder to [lie about][HappinessReport].

## Projects

Below is a quick summary of some of the actual projects I've been working on.

### Phone Cases

This project was an excellent example of how we introduce new products, and also gave some good insights into how people think (differently) about doing business here in general.  
<br/>
There is a slight difference between what each of the departments think about new product introduction. Sometimes, adding a new photo book to our portfolio with a different size or orientation is referred to as new or even an innovation, though in IT this is something we tend to call configuration.  
<br/>
Introducing [phone cases][PhoneCases], on the other hand, started as a real experiment because it required a whole new product line. It was a great opportunity for me to learn the details of our infrastructure in general, as it involved changes to all the major components of our flow. New editors were required, so our customers could design their product, we had to adjust our checkout process, so customers could order it, and finally, we had to expand and customize our production facilities so we could fulfill the orders.  
<br/>
![Phone cases][PhoneCasesImage]  
<br/>
The project was a huge success; our customers loved it, the implementation went quite smoothly, and the business expectations were overachieved starting from day one. Based on that, I was expecting a much faster response from our side and quicker expansion of this part of the portfolio, but at least we have made some progress around this since then.

### Checkout Redesign

This project was a must-have, bringing our checkout flow up-to-date in the context of user experience and modern web standards. I think that, unfortunately, we missed the point a bit here.  
<br/>
Our checkout application is a classic monolith - too complicated to understand, too fragile to change. Changes were inevitable but, in my opinion, were carried out in a sub-optimal way.  
<br/>
The project was based on extensive [UX] research and great ideas but done in the classic [waterfall][Waterfall] approach. By the time we released the new system, some of the core ideas were more than two years old, and they might not have reflected the actual customer needs (as they haven't done it since then).  
<br/>
![Checkout Redesign][CheckoutRedesignImage]  
<br/>
Our frontend developers did a great job implementing the markup according to the latest web standards, but unfortunately, the backend kept the monolith growing instead of taking the chance of making the whole system more maintainable. We ended up in a death march, cutting some major parts of the original scope (this is not necessarily a problem, "just" caused a lot of frustration), resulting in a quite stressful and time-consuming, though in the end successful big bang release.

### SSO

I think we missed improving our overall user experience in general for a long time, focusing only on parts of our flow as separate entities, resulting in weird behavior like as many apps we had, the customer needed to authenticate again and again in all of them. You sign in to save your product in the editor, then sign in to order it in the checkout, and then sign in to the dedicated frontend to check its status.  
<br/>
We are only a short step away from closing this gap and implementing our [single sign-on][SSO] solution for the last component of our pipeline too. The solution is based on industry-standard technologies and protocols ([OpenID Connect][OpenIDConnect], [OAuth 2.0][OAuth20]), to replace the diverse set of authentication and authorization methods used earlier.  
<br/>
![SSO][SSOImage]  
<br/>
This project was also a long journey, but all done in a backwards-compatible, incremental way, according to the industry's best practices. The new identity stack is our team's flagship product now. "Despite" the inherent complexity of security in general, it is designed to be of excellent quality and maintainability, working with high performance and being highly reliable. It is the proof that you can do it differently, even surrounded by a lot of legacy components. It's all [possimpible][Possimpible].

## State of the print

Based on the idea of having [20% of our time dedicated to innovation][20PercentInnovation], we have a dev day once a month, when, given that it's slightly related to Albumprinter, people can choose freely what to work on. Increasing the frequency of this event by bringing it to closer to the above percentage, together with bringing back [Hackathons][Hackathon] to live, could be a huge boost to improving our workflow and infrastructure in general. Even with the above setup, most of the significant achievements we've had recently were more or less related to these initiatives.  

* **Just code**
  * *Back then* Use [SVN], alone in the dark.
  * **Now** Collaborate extensively using [GitHub] pull requests, work in pairs.
* **Deployment**
  * *Back then* Merge binaries and configurations through SVN and [Robocopy] the hell out of it.
  * **Now** [Octopus Deploy][Octopus].
* **Share functionality**
  * *Back then* Contribute to a shared class library and propagate it everywhere [if you can][log4net].
  * **Now** Deploy a new [microservice][Microservice] in hours.

We parted ways with [HEMA] earlier this year but took the chance to strengthen our own main brand [Albelli].  
<br/>
We're currently migrating the services of the Norwegian brand [FotoKndusen] (again, represented by [The Scream][TheScream] above) to our platform. This project has the same issues as Checkout Redesign had, but on a much larger scale. We are doing our best to avoid the risks of the waterfall approach and to minimize the impact of the big bang release two weeks from now.  
<br/>
We have introduced the term ![AP-later][AP-later] for tagging things which we think will never happen.

## Future

I recently received a recognition award from Albumprinter for my achievements during the last quarter. Together with the award came a 50 EUR [bol.com] voucher, which I spent on contributing back to the people (that is, all of my colleagues) who played a significant part in these. Now our list of offline resources is extended with:

* A copy of [Agile Project Management For Dummies][AgileBook].
* A copy of [IT Architecture For Dummies][ArchitectureBook].
* Two pairs of [welding goggles][WeldingGoggles].

After the FotoKnudsen migration, we can use these to take a step back, and reevaluate our goals and strategies. It would be a perfect time to, after making some agreements, start doing something actual about them.  
<br/>
I will push for bridging the gaps between the various departments by extending (reintroducing) the adoption of [Agile], and setting up our ubiquitous languages for our problem domains based on [Domain Driven Design][DDD]. It seems that once we are quite familiar with the [repository pattern][Repository], it might make sense to get back to the basics.

## Summary

Thanks for all the great support to:

* Her.
* All my current and ex-colleagues at Albumprinter.
* All the people of the Netherlands.

And, of course, "[God, bless the Hungarians][Himnusz]".

## Resources

* [We are hiring in one year!][AlbelliJobs]

[Albumprinter]: http://www.albumprinter.org/
[TheScream]: https://en.wikipedia.org/wiki/The_Scream
[Busy]: http://www.amazon.com/Busy-How-Thrive-World-Much/dp/1455532983/

[Hungary]: https://en.wikipedia.org/wiki/Hungary
[Amsterdam]: https://www.iamsterdam.com/en/
[Netherlands]: https://en.wikipedia.org/wiki/Netherlands
[EnteringAlbumprinterImage]: {{ site_url }}/images/4/entering-albumprinter.jpg
[CentraalStation]: https://en.wikipedia.org/wiki/Amsterdam_Centraal_station
[DutchLunch]: http://www.iamexpat.nl/read-and-discuss/lifestyle/articles/lunch-break-dutch-style

[CET]: https://en.wikipedia.org/wiki/Central_European_Time
[SomeFactAboutHungary]: http://9gag.com/gag/6832266/some-fact-about-hungary
[ChainOfScreaming]: http://how-i-met-your-mother.wikia.com/wiki/The_Chain_of_Screaming_(theory)
[EarlyDaysImage]: {{ site_url }}/images/4/early-days.jpg
[GDP]: https://en.wikipedia.org/wiki/Gross_domestic_product
[HappinessReport]: https://en.wikipedia.org/wiki/World_Happiness_Report

[PhoneCases]: http://www.albelli.co.uk/products/photo-phone-cases
[PhoneCasesImage]: {{ site_url }}/images/4/phone-cases.jpg
[UX]: https://en.wikipedia.org/wiki/User_experience
[Waterfall]: https://en.wikipedia.org/wiki/Waterfall_model
[CheckoutRedesignImage]: {{ site_url }}/images/4/checkout-redesign.jpg
[SSO]: https://en.wikipedia.org/wiki/Single_sign-on
[OpenIDConnect]: http://openid.net/connect/
[OAuth20]: http://oauth.net/2/
[SSOImage]: {{ site_url }}/images/4/sso.jpg
[Possimpible]: http://treasure.diylol.com/uploads/post/image/387049/resized_barney-stinson-meme-generator-possimpible-where-possible-and-impossible-meet-a9c0d9.jpg

[20PercentInnovation]: http://uk.businessinsider.com/google-20-percent-time-policy-2015-4
[Hackathon]: https://en.wikipedia.org/wiki/Hackathon
[SVN]: https://subversion.apache.org/
[GitHub]: https://github.com/
[Robocopy]: https://technet.microsoft.com/en-us/library/cc733145(v=ws.11).aspx
[Octopus]: https://octopus.com/
[log4net]: http://haacked.com/archive/2012/02/16/changing-a-strong-name-is-a-major-breaking-change.aspx/
[Microservice]: http://martinfowler.com/articles/microservices.html
[HEMA]: http://www.hema.nl/
[Albelli]: http://www.albelli.nl/
[FotoKndusen]: http://www.fotoknudsen.no/
[bol.com]: https://www.bol.com/
[AgileBook]: https://www.bol.com/nl/p/agile-project-management-for-dummies/1001004010936109/
[ArchitectureBook]: https://www.bol.com/nl/p/it-architecture-for-dummies/1001004007560364/
[WeldingGoggles]: https://www.bol.com/nl/p/skandia-lasbril-opklapbaar-kleur-5/9200000010409348/
[Agile]: http://www.agilemanifesto.org/
[DDD]: https://en.wikipedia.org/wiki/Domain-driven_design
[Repository]: http://martinfowler.com/eaaCatalog/repository.html

[AP-later]: https://bit.ly/AP-later

[Himnusz]: https://en.wikipedia.org/wiki/Himnusz

[AlbelliJobs]: http://www.albelli-jobs.com/
