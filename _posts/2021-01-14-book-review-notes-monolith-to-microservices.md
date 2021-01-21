---
layout: post
title: "Book review notes: Monolith to Microservices"
date: 2014-09-08 15:29:30 -0600
comments: true
tags: [Book-Review, Architecture]
---
Evolutionary Patterns to Transform your Monolith - an honest appraisal of the challenges associated with microservice architecture, and help you understand whether starting this journey is even right for you.

It covers from domain-driven design to organizational change model - vital underpinnings that will stand you in good stead even if you decide not to adopt a microservice architecture.

# CHAPTER:1 - Just Enough Microservices

* Have a common, shared understanding about what microservice architectures are.
* Address some common misconceptions as well as nuances that often missed.

## What Are Microservices?
* **Independently deployable** services modeled around **a business domain**.
* Expose business capability via well defined **API interface** - contract.
* **Encapsulate inner-working** of the business capability and its data storage and retrieval.
* Less cross-service changes as infrequent as possible.
* Service should decide what is shared and what is hidden.
* End-to-end slice of a business functionality.

#### Independent Deployability
#### Modeled Around a Business Domain
#### Own Their Own Data

#### What Advantages Can Microservices Bring?
* Independent nature of deployment opens up new model for improving the scale and robustness of system.

#### What Problems Do They Create?
#### User Interfaces
#### Technology
#### Size
#### And Ownership
* Reducing services that are shared across multiple teams is key to minimizing **delivery contention** - Business Oriented microservice architecture

## The Monolith
Kinds:
* The Single Process Monolith
* The Distributed Monolith
* Third-Party Black-Box Systems

#### Challenges of Monoliths
* Delivery contention
* Confused lines of ownership

#### Advantages of Monoliths
* Simpler end-to-end testing
* Single place to monitor and troubleshoot
* Simplify code reuse
* Monolith is synonymous with legacy - this is a problem.
* It is valid option - like microservice

## On Coupling and Cohesion
* Understand the balancing forces between coupling and cohesion

#### Cohesion
* How we group related code. 
* The code that changes together, stays together

#### Coupling
* How changing one thing requires a change in another

> Information Hiding, like dieting, is somewhat more easily described than done. <br/>
> -David Parnas, The Secret History Of Information Hiding

###### Implementation coupling
* A is coupled to B in teams of how B is implemented - when the implementation of B changes, A also changes.
* A classic and common example of implementation coupling comes in the form of sharing database. 
* The act of hiding a database behind *well-defined service interface* allows the service to limit the scope what is exposed and can allow us change how this data is represented.
* Outside-in thinking: to help service interface design.

###### Temporal coupling
* Key challenges of synchronous calls in a distributed environment.

###### Deployment coupling
* Everything must be deployed together
* Deploying something comes with risk.
* Small releases make for less risk - there is less to go wrong.

###### Domain coupling
* Fundamentally, In a system that consists of multiple independent services, there has to be some interaction between participants. 
* In microservice architecture, domain coupling is the result.
* We can't avoid the domain coupling. But we still aim to reduce the level of coupling

## Just Enough Domain-Driven Design
* Programs better represent the real world.
* Helps us better represent the problem domain in our programs.

#### Aggregate
* Representation of a real domain concept
* Typically have a life-cycle around them
* Self contained unit
* There are lots of ways to break system - some choices being highly subjective.
	1. Performance reason
	1. Easy of implementation

#### Bounded Context
* Represent a large organizational boundary within an organization.
* Hide implementation detail.
* Contain one or more aggregates 

#### Mapping Aggregate and Bounded Contexts to Microservices
* They both give us unit of cohesion with well-defined interfaces with the wider system.
* Works well as service boundary.

### Footnotes
* [“Contempt Culture” blog post](http://bit.ly/2oeICgL)
* For an overview of Shopify’s thinking behind the use of a modular monolith rather than microservices, Kirsten Westeinde’s [talk on YouTube](http://bit.ly/2oauZ29) has some useful insights.


# CHAPTER:2 - Planning a Migration
## Understanding the Goal
* Microservices are not the goal. You don't "win" by having microservices.
* Think of migrating to microservices architecture in order achieve something that you can't currently achieve with your existing system architecture.

#### Three Key Questions
* What are you hoping to achieve?
* Have you considered alternatives to microservices architecture
* How will you know if the transition is working?

## Why Might You Choose Microservices?

{: .box-note} 
**But There are other ways you could potentially use to achieve these same outcomes using different approaches.**

#### Improve Team Autonomy
> Whatever industry you operate in, it is all about your people, and catching them doing things right, and providing them with the confidence, the motivations, the freedom and desire to achieve their true potential. <br/>
>      -John Timpson

{: }
	• Distribution of responsibility 
	• Self-service approach - not having to wait for people to do things for you.

#### Reduce Time to Market
* **Path-to-production** modeling exercise - speed up the delivery of software.
* Think of all the steps involved with shipping software.

#### Scale Cost-Effectively for Load
* Scale up only parts of the processing that are currently constraining our ability to handle load.
* Look for bottlenecks

{: }
	• Look at public cloud - a quick short-term improvements, it shouldn't be dismissed outright.

#### Improve Robustness
* An impact on one area of the functionality need not bring down the whole system.

{: .box-note} 
**Resilience:** When we want to improve a system's ability to avoid outages, handing failures gracefully when they occur, and recover quickly when problems happen

#### Scale the Number of Developers
* We can scale the number of developers by reducing the delivery contention.

{: .box-note} 
To successfully scale number of developer we bring to bear on the problem requires a good regress of **autonomy** between the teams themselves - just having microservices not going to be enough

#### Embrace New Technology
* The flexibility is being able to try new technology in a safe way can give them competitive advantage - both in terms of delivering better results for customer and in helping keep developers happy as they master new skills.

{: .box-note} 
**Reuse?** <br/>
	• Reuse is one of the most opt-stated goals for microservices migration - a poor goal in the first place. <br/>
	• May not always be the right answer. If your actual goal is faster time to market, writing our own implementation much faster and ship the feature to the customer more quickly than spend the time to adapt the existing code. <br/>
	• Spend time focusing on the actual objective.<br/>
	• If you optimize for reuse hoping you get faster time to market, you may end up doing things that slow you down.

## When Might Microservices Be a Bad Idea?
#### Unclear Domain
* Having an existing codebase you want to decompose into microservices is much easier than trying to go to microservices from the beginning.

#### Startups
* It is much easier to partition an existing "brownfield" system than to do so up front with a new, greenfield system that a startup would create. 
* Only split around those boundaries that are clear at the beginning and keep the rest on the more monolith side.

## Trade-Offs
* Separate the core driver behind the shift from any secondary benefits you might also like to achieve. 
	- Some things are more important than others.
	- Slider exercise - change priorities as you learn more.
		- Scale to handle increasing numbers of customers
		- Improve team autonomy
		- Bring in new programming language
		- Decrease system downtime

## Taking People on the Journey
* When people disagree about an approach, its because they may have different view of what you are trying to achieve. 
* You need to bring other people on the journey with you - have a shared understanding about what you are trying to achieve.
* If all in the organization share the same goal, they are much more likely to be onboard for making a change.

#### Changing Organizations
* Establishing a Sense of Urgency
* Creating the Guiding Coalition
* Developing a Vision and Strategy
* Communicating the Change Vision
* Empowering Employees for Broad-Based Action
* Generating Short-Term Wins
* Consolidating Gains and Producing More Change
* Anchoring New Approaches in the Culture

## Importance of Incremental Migration

{: .box-warning}
> If you do a big-bang rewrite, the only thing you're guaranteed of is a big bang. <br/>
> -Martin Fowler

* Break the big journey into small stages - each one can be analyzed and learned from.
* Fan of iterative software delivery since even before the advent of agile - accepting that will make mistakes, and therefore need a way to reduce the size of those mistakes.
* Break the big journey into lots of little steps. Each step can be carried out and learned from.

#### It’s Production That Counts
* microservices decomposition can cause issues with troubleshooting, tracing flows, latency, referential integrity, cascading failures, and a host of other things. 

## Cost of Change

{: .box-warning}
If you are not making decisions, the progress will grind to a halt.

* Reversible and Irreversible Decisions
	- Type 1 decision: Irreversible one-way door
	- Type 2 decision: Reversible two-way door

* Easier Places to Experiment
	- Make mistakes where the impact will be lowest.
	- Do much of thinking in place where the cost of change and the cost of mistakes is as low as it can be: **the white-board**.
	- Sketch out the proposed design.

## So Where Do We Start?
* When it comes to decomposing an exiting monolithic system, we need to have some form of logical decomposition to work with, and this is where **domain-driven design** can come in handy.
* **Domain-Driven Design**:
	- How Far Do You Have to Go?
		- Coming up with a detailed domain model of the entire system may be daunting.
		- *Just enough* information to make a reasonable decision about where to start our decomposition.
	- Event Storming
		- the output of this exercise isn't just the model itself - it is the *shared understanding* of the model.
	- Using a Domain Model for Prioritization

## A Combined Model
* Increasing ease of decomposition.
* Increasing benefit of decomposition.
* Come up with simple two-axis model - `x-axis` represents the value of the decomposition and `y-axis` represents their difficulty.

## Reorganizing Teams

#### Shifting Structures
* Shifting structures: Business Analyst => Development => Test team.
* Dedicated test teams are now a thing of the past of many orgs. Instead, test specialists are becoming an integrated part of delivery teams, enabling developers and testers to work more closely together.
* Specialist's responsibility has shifted from doing to enabling - creating self-service tooling, provide training or a whole host of other activities.
* Independent, autonomous teams able to be responsible for more of the end-to-end delivery cycle than ever before.

#### It’s Not One Size Fits All

{: .box-warning}
Copying other people's organizational design can be dangerous.

* Change needs to be based on your context, your working culture, and your people.
* Bring changes in an incremental fashion.

#### Making a Change
* Model your path to production - you could overlay those ownership boundaries on an exiting view.
* Have `as-is` state and `six months from now` state.

#### Changing Skills
* Self-asses
* Build up a visual representation
* Keep the self-assessments private is very important

## How Will You Know if the Transition Is Working?

#### Having Regular Checkpoints

* Pause and reflect: 
	- Restate what you are expecting
	- Review any quantitative measures
	- Ask for qualitative feedback
	- Decide if anything going to change

#### Quantitative Measures

{: .box-warning}
It's worth noting that metrics can be dangerous because if the old adage "You get what you  measure". Metrics can be gamed - inadvertently or on purpose.

* **If it is time to market**: measuring cycle time, number of deployments and failure rates make sense. 
* **If it is scale**: reporting on the latest performance test would be sensible. 


#### Qualitative Measures

{: .box-warning}
Ignoring what people are telling you in favor of relying entirely on quantitative metrics is a great way to yourself into a lot of trouble.

> ...Software is made of feelings. <br/>
>   -Astrid Atkinson (@shinynew_oz)

* Whatever our data shows us, it's people who build the software and it's important that their feedback is included in measuring success.
	- Are they enjoying the process?
	- Do they feel empowered?
	- Or do they feel overwhelmed?
* Do sense check of what is coming from team.	

#### Avoiding the Sunk Cost Fallacy
* Make each step a small one, it becomes easier to avoid the pitfalls of *the sunk cost fallacy*  

#### Being Open to New Approaches
* Try new things, or sometimes just letting things settle for a moment to let you see what impact it is having.
* Embrace a culture of **constant improvement**, to always have something new you are trying, then it becomes much more natural to change direction when needed

### Footnotes
* The term “burning platform” is typically used to denote a technology that is considered end-of-life. It may be too hard or expensive to get support for the technology, too difficult to hire people with the relevant experience. A common example of a technology most organizations consider a burning platform is a COBOL mainframe application.
* Kotter’s change model is laid out in detail in his book Leading Change (Harvard Business Review Press, 1996).


# CHAPTER:3 - Splitting the Monolith

{: .box-warning}
Remember that we want to make our migration incremental. We want to migrate over to a microservices architectures in small steps, allowing us to learn from the process and change our mind if needed.

## To Change the Monolith, or Not?
* Cut, Copy, or Reimplement?
* Refactoring the Monolith
	- Find **seam** - a place where you can change the behavior of a program without having to edit the exiting behavior.
	- A modular monolith?
	- Incremental rewrites
		- Always to attempt to *salvage* the existing codebase first, before resorting to just reimplementing functionality.

## Migration Patterns

{: .box-warning}
Make sure you understand the pros and cons of each of these patterns. They are not universally the "right" way to do things.

{: .box-error .center}
**Separating the concepts of *deployment* from *release* is important.** <br/>
	• Just because software is deployed into a given environment doesn't mean it's actually being used customers. <br/>
	• By treating the two things separate concepts, you enable the ability to validate your software in the final production environment before it is being used, allowing you to de-risk the rollout of the new software. <br/>
	• Patterns like **the strangle fig, parallel run, and canary release** are among those patterns that make use of the fact that *deployment* and *release* are separate activities. <br/>


## Pattern: Strangler Fig Application
* A technique that has seen frequent use when doing system rewrites is called the [strangler fig application](http://bit.ly/2p5xMKo)
* How it works:
	1. Copy the code from the monolith (if possible) Or else reimplementing the functionality in question.
	1. Reroute calls from the monolith over to the shiny new microservices
* Changing Protocols:
	> "Keep the pipes dumb, the endpoints smart"
	* Service meshes?

## Changing Behavior While Migrating Functionality

{: .box-warning}
When migrating functionality, try to eliminate any changes in the behavior being moved - delay new features or bug fixes until the migration is complete if you can. Otherwise, you may reduce your ability to roll back changes to your system.


## Pattern: UI Composition
* Example: Page Composition
* Example: Widget Composition
* Example: Micro Frontends

## Pattern: Branch by Abstraction
* Helps to reduce the disruption to a minimum
* Allows the implementations to safely coexist alongside each other, in the same version of code, without causing too much disruption.
* How it works:
	1. Create abstraction
	1. Use abstraction
	1. Create new implementation
	1. Switch implementation
		- Use feature-toggles
	1. Clean up
* As a Fallback Mechanism
	* Steve Smith details a variation of the branch by abstraction pattern called [verify branch by abstraction](http://bit.ly/2mLVevz) that also implements a live verification step
* Where to Use It
	- A fairly general-purpose pattern - useful in any situation where changes to the existing codebase are likely going to take time to carry out, but where you want to avoid disrupting 
	- It is a better option than the use of long-lived code branches in nearly all circumstances.

## Pattern: Parallel Run
* When using a **parallel run**, rather than calling either the old or the new implementation, instead we call both, allowing us to compare the results to ensure they are equivalent.
* Despite calling both implementations, only one is considered the source of truth at any given time.
* The old implementation is considered the source of truth until the ongoing verification reveals that we can trust our new implementation.

#### Verification Techniques
- Using Spies
	* A `Spy` can stand in for a piece of functionality, and allows us to verify after that fact that certain things were done. 
	* It is useful where for example, we wouldn't want to send an email to our customer twice.

- GitHub Scientist
- Dark Launching and Canary Releasing
	- Canary release involves directing some subset of users to the new functionality
	- **Parallel run** is a way of implementing dark launching
- All these techniques fall under the banner of what is called **progressive delivery** - an umbrella term coined by [James Governor](http://bit.ly/2lZjrxK)


####  Where to Use It: 
* Use it for those cases where the functionality being changed is considered to be high risk. 


## Pattern: Decorating Collaborator

## Pattern: Change Data Capture
* React to changes made in a datastore.

#### Implementing Change Data Capture
* We could use various techniques to implement change data capture, all of which have different trade-offs in terms of complexity, reliability, and timeliness. 
* Database triggers
	> "Having one or two database triggers isn't terrible. Building a while system off them is a terrible idea." <br/> - Randy Shoup
	* Like stored procedures, database triggers can be a *slippery slope.*
* Transaction log pollers
	* Only committed transactions will show up in the transaction log (which is sort of the point).
	* [_Debezium_](https://debezium.io/) is an open source distributed platform for change data capture.
* Batch delta copier
	* The most simplistic approach is to write a program that on a regular scheduler scans the database in question for what data has changed.

####  Where to Use It: 
* Unable to intercept either at the perimeter of the system using a strangler or decorator, and cannot change the underlying codebase.
* CDC reading from transaction logs can add significant complexity to your solution. 


# CHAPTER:4 - Decomposing the Database

{: .box-error .center}
Microservices work best when we practice information hiding, which in turn typically leads us to toward microservices totally encapsulating their own data storage and retrieval mechanisms.

* Splitting a database apart is far from a simple endeavor.
	- Data synchronization
	- Logical vs Physical schema decomposition
	- Transational integrity
	- Joins
	- Latency
	- And more

## Pattern: The Shared Database
* A number of issues related to sharing a single database among multiple services
	- No idea what is shared and what is hidden - which flies in the face our drive toward information hiding.
	- Unclear as to who "controls" the data.
	- Where the business logic that manipulates the data
	- Is it spread across services?

#### Where to Use It.
* Read-only static reference data and data structure is **highly stable.**

## But It Can’t Be Done!
* So, ideally, we want our new services to have their own independent schemas. But that's not where we start with an existing monolithic system. 
* Though, remain convinced that in most situations that is the appropriate thing to do, but it isn't always feasible initially.
	* Ex: Sensitive part of the system

## Pattern: Database View
* With a view, a service can be presented with a schema that is a limited projection from an underlying schema.
* This projection can limit the data that is visible to the service, hiding information it shouldn't have access to.

#### Possible Options
* The Database as a Public Contract
* Views to Present
	- Using views to allow the underlying schema to change.

#### Limitations
* Not all NoSQL databases don't support views

#### Ownership
* Careful consideration should be given to who "owns" the view.

#### Where to Use It.
* When it is impractical to decompose the existing monolith schema.
* If you feel that the effort of full decomposition is too great, then this can be a step in the right direction.

## Pattern: Database Wrapping Service

{: .box-warning .center}
Sometimes, when something is too hard to deal with, hiding the mess can make sense. With the *database wrapping service patter,* we do exactly that: hide the database behind a service that acts as a thin wrapper, moving database dependencies to become service dependencies.

* It could be argued we're just putting a bandage over the problem, rather than addressing the underling issues.
* It clearly delineates what is "yours" versus what is "someone else's"
* The service API needs to be properly embraced as a managed interface with appropriate oversight over how this API layer changes.

#### Where to Use It.
* When the underlying schema is just too hard to consider pulling apart.
* Use *the database wrapping service pattern* to reduce dependence on a central database.

## Pattern: Database-as-a-Service Interface

#### When to Use It.
* Sometimes, clients just need a database to query. It could be because they need to query or fetch large amounts of data, or external parties are already using tool (like Tableau) changes that require a SQL endpoint to work against.

{: .box-warning .center}
**Reporting Database Pattern?** <br/>
	• Martin Fowler has already documented this under the [reporting database pattern](http://bit.ly/2kWW9Ir), so why different name here? <br/>
	• The ability to allow clients so define ad hoc queries has broader scope than traditional batch-oriented workflows.

* One approach work well is to create a dedicated database designed to be exposed as `read-only` endpoint, and have this database populated when the data in the underlying database changes.
* The same that a service could expose a stream of events as one endpoint, and a synonymous API as endpoint, it could also expose a database to external consumers.

#### Implementing a Mapping Engine
* The mapping engine acts as an abstraction layer between the internal and external databases.
* When our internal database changes structure, the mapping engine will need to change to ensure that the public-facing database remains consistent. 
* Options: 
	* Change data capture system could be an excellent choice.
		* debezium?
	* Have a batch process just copy the data over - this can be problematic as it is likely to lead to a longer lag between internal and external databases. 
	* Listen to events fired from the service in question, and use that to update the external database.

#### Where to Use It.
* This is useful only for clients who need read-only access.
* It fits reporting use cases very well - situations where your clients may need to join across large amounts of data that a given service holds.
* Could be extended to then import this database's data into larger data warehouse, allowing multiple services to be queried. 

{: .box-error .center}
• Don't underestimate the work required to ensure that this external database projection is kept properly up-to-data. <br/>
• Depending on how your current service is Implemented, this might be a complex undertaking.

## Transferring Ownership
* As you split services out from the monolith, some of the data should come with you - and some of it should stay where it is.
* If the new microservices needs to interact with an aggregate that is still owned by the monolith, we need to expose this capability via a well-defined interface. 
* Options: 
	* Pattern: Aggregate Exposing Monolith
	* Pattern: Change Data Ownership

## Pattern: Aggregate Exposing Monolith
* Expose information from the monolith via a proper service interface, allowing our new microservice to access it.

#### Where to Use It.
* In the long term is a much better idea, having the new service call back to the monolith to access the data it needs is likely little more work than directly accessing the database of the monolith.

## Pattern: Change Data Ownership
* What happens when we consider data that is currently in the monolith that should be under the control of newly extracted service?
* New service where **the life cycle** of the data should be managed.

#### Challenges:
* The data should be moved from where it is, over into the new service. 
* **Of course, the process of moving data out of an existing database is far from a simple process.**

## Data Synchronization
* Possible options:
	* Read directly from the monolith for a short space of time.
		* You should consider this only as a very short-term measure.
		* Leaving a shared database in place for too long can lead to significant long-term pain.
	* Avoid big-bang switch over 
		- Hard to fall back to using the functionality in the existing monolithic system.
		- Could end-up losing data.
	* Sync two databases via code.

## Pattern: Synchronize Data in Application
* Step 1: Bulk Synchronize Data
* Step 2: Synchronize on Write, Read from Old Schema
	* The App keeps both database in sync, but uses one only for reads
* Step 3: Synchronize on Write, Read from New Schema
	* The new database is now the source of the truth, but the old database is still kept in synchronization.

#### Where to Use It.
* If you want to split the schema *before* splitting out the application code.

## Pattern: Tracer Write
* We move the source of the truth for data in an incremental fashion, toleration there being tow sources of truth during the migration.
* Allows for a phased switchover, reducing impact of each release, in exchange for being more tolerant of having more than one source of truth.

#### Data Synchronization
* The data be inconsistent for a window of time
* Eventual consistency
* You may need reconciliation process to ensure that the synchronization is working as intended.
* Synchronize using background worker
* Synchronize using an event-driven message
* Implementation of the synchronization is likely to be where most of the work lies.

## Splitting Apart the Database
* Find *seams* in databases too so we can split them out cleanly. Database, however, are tricky beasts.
* Physical Versus Logical Database Separation
	* Logical decomposition allows for simpler independent change, information hiding.
	* Physical decomposition potentially improves system robustness, could help remove resource contention.

## Splitting the Database First, or the Code?

{: .box-success .center}
**Tools** <br/>
	• FlywayDB <br/>
	• SchemaSpy <br/>

#### Splitting the Database First
* We end up breaking transactional integrity
* Splitting schema first may allow you to spot issues with performance an transactional integrity.
* The flip side is that this approach is unlikely to yield much short-term benefit. We still have a monolithic code deployment.
* Pattern: **Repository per bounded context**
	* Break down repositories along the lines of bounded contexts.
* Pattern: **Database per bounded context**
	* Once you have clearly isolated data access from the application point of view, it makes sense to continue this approach into schema.
	* Before we get to separating out the application code, we can start this decomposition by clearly separating our database around the lines of our identified bounded contexts.



#### Splitting the Code First
* Splitting the application tire first leaves us with a single shared schema.
* By splitting out application tier, it becomes much easier to understand what data is needed by the new service.
* **Concern:** Teams may get this far and then stop.
* **Concern:** You are storing up trouble for the future.
* **Concern:** You are delaying finding out nasty surprises caused by pushing join operations up into the application tier.
* Pattern: Monolith as data access layer (via exposing an API)
* Pattern: Multischema storage

#### So, Which Should I Split First?
* Split the schema first: when potential impact to performance or data consistency.
* Otherwise, Split the code first

#### Split Database and Code Together
* Much bigger step to take, and it will be longer before you can assess the impact of your decision as a result.

## Schema Separation Examples
#### Pattern: Split Table
* Single table that bridges two bounded contexts

#### Pattern: Move Foreign-Key Relationship to Code
* No longer database join work
* Maybe data inconsistentency

#### Moving the Join
* Move the join operation to the service, rather than in the database.

{: .box-success .center}
**Tracing** <br/>
	• [Jaeger: open source, end-to-end distributed tracing](https://www.jaegertracing.io/) <br/>
	• Monitor and troubleshoot transactions in complex distributed systems.

#### Data Consistency
* Check before deletion
* Handle deletion gracefully
* Don't allow deletion
* So how should we handle deletion?

#### Where to Use It

#### Example: Shared Static Data
* Pattern: Duplicate static reference data
* Pattern: Dedicated reference data schema
* Pattern: Static reference data library
* Pattern: Static reference data service

## Transactions
## Sagas

# CHAPTER:5 - Growing Pains
## More Services, More Pain
## Ownership at Scale
## Breaking Changes
## Reporting
## Monitoring and Troubleshooting
## Local Developer Experience
## Running Too Many Things
## End-to-End Testing
## Global Versus Local Optimization
## Robustness and Resiliency
## Orphaned Services

# CHAPTER:6 - Closing Words

# In Summary



