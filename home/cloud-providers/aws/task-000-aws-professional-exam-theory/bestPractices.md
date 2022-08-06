# Best Practices

## Migration Strategies

[CheatSheet - aws-migration-strategies-the-6-rs](https://tutorialsdojo.com/aws-migration-strategies-the-6-rs)

[Phase 2: Plan](https://docs.aws.amazon.com/prescriptive-guidance/latest/strategy-database-migration/planning-phase.html)


6 Application Migration Strategies: “The 6 R’s”

- Rehosting : Otherwise known as `lift-and-shift`.
  - large legacy migration scenario where the organization is looking to scale its migration quickly to meet a business case, we find that the majority of applications are rehosted.
- Replatforming : I sometimes call this `lift-tinker-and-shift`.
  - Here you might make a few cloud (or other) optimizations in order to achieve some tangible benefit, but you aren’t otherwise changing the core architecture of the application.
  - You may be looking to reduce the amount of time you spend managing database instances by migrating to a database-as-a-service platform like Amazon Relational Database Service (Amazon RDS), or migrating your application to a fully managed platform like Amazon Elastic Beanstalk.

- Repurchasing : Moving to a different product.
  - I most commonly see repurchasing as a move to a SaaS platform. 
- Refactoring / Re-architecting : Re-imagining how the application is architected and developed, typically using cloud-native features.
  - This is typically driven by a strong business need to add features, scale, or performance that would otherwise be difficult to achieve in the application’s existing environment.
- Retire : Get rid of.
  - Once you’ve discovered everything in your environment, you might ask each functional area who owns each application. 
  - We’ve found that as much as 10% (I’ve seen 20%) of an enterprise IT portfolio is no longer useful, and can simply be turned off. 
- Retain : Usually this means “revisit” or do nothing (for now).
  - Maybe you’re still riding out some depreciation, aren’t ready to prioritize an application that was recently upgraded, or are otherwise not inclined to migrate some applications. 
  - You should only migrate what makes sense for the business;

## Disaster Recovery

[Disaster Recovery Slides](https://www.slideshare.net/AmazonWebServices/disaster-recovery-options-with-aws)