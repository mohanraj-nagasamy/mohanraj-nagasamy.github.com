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

## Cost of Change
## So Where Do We Start?
## Domain-Driven Design
## A Combined Model
## Reorganizing Teams
## How Will You Know if the Transition Is Working?
## Summary
