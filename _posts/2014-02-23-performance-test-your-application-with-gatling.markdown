---
layout: post
title: "Performance test your application with Gatling"
date: 2014-02-23 19:18:00 -0700
comments: true
tags: Performance
---

When you think about performance testing your application, you may think about the below picture and a tool to test.

![image-center](/assets//images/posts/truck-load.png){: .align-center}

One open source tool that comes to mind is [JMeter](http://jmeter.apache.org/). For very simple tests, I tend use [apache benchmarking](http://httpd.apache.org/docs/2.2/programs/ab.html). But there are other tools like [Grinder](http://grinder.sourceforge.net/), [LoadRunner](http://www8.hp.com/us/en/software-solutions/software.html?compURI=1175451), [NeoLoad](http://www.neotys.com/product/overview-neoload.html), [Tsung](http://tsung.erlang-projects.org/), and [SoapUI](http://www.soapui.org/Getting-Started/load-testing.html) for web services testing. Then there is [Caliper](https://code.google.com/p/caliper/) and [jmh](http://openjdk.java.net/projects/code-tools/jmh) for micro benchmarking, which target use cases.

<!-- more -->


##### So what makes [Gatling](http://gatling-tool.org/) different from other tools is:

* Usability – GUI vs Script (Code)
* Maintainability
* Reporting
* Integration with other tools like Maven, Jenkins
* Underlying Technologies

#### Usability – GUI vs Script (Code)

Using the GUI to do performance tests is difficult and unintuitive.

Gatling provides an elegant [DSL](http://gatling-tool.org/cheat-sheet/) written in [Scala](http://www.scala-lang.org/) to describe your test scenarios of your app. DSL scripts are intuitive and simple to create. Using the recorder (like [JMeter](http://jmeter.apache.org/)) it can generate scripts that will look similar to a hand written one. Your can then tweak the generated scripts anyway you want.

You don’t have to know Scala to write scripts. You can get an introduction [here](http://twitter.github.io/scala_school/) or just think of them as Javascript code (at least for usage purpose). Scals’s variable declarations are either by var (mutable variable) or by val (immutable variable).

```scala
val httpConf = http.baseURL("https://twitter.com")
val scn = scenario("Twitter test")
	.exec(
		http("get login")
		.get("/")
		.check(authenticity_token))
	.exec(
		http("post login & get the twitter page")
		.post("/sessions")
		.param("session[username_or_email]", username)
		.param("session[password]", password)
		.param("authenticity_token", authenticity_token)
		.check(status.is(200))
		.check(bodyString("test_some_text").exists)
		.check(regex("<strong>444</strong> Tweets").exists))
	.exec(
		http("logout from twitter")
		.post("/logout")
		.check(status.is(200)))

setUp(scn.inject(atOnce(2 users))).protocols(httpConf)

```

I created the above script, which load tests the twitter.com site. You can checkout the full source code [here](https://github.com/mohanraj-nagasamy/gatling-maven-plugin-demo), which is a cloned maven project from [gatling-maven-plugin](https://github.com/excilys/gatling/tree/master/gatling-maven-plugin). Take a look at the [TwitterSimulation.scala](https://github.com/mohanraj-nagasamy/gatling-maven-plugin-demo/blob/master/src/test/scala/twitter/TwitterSimulation.scala) file that I added to the project.

Once downloaded, execute with the following maven command with your tweeter username and password:

```
mvn gatling:execute -Dgatling.simulationClass=twitter.TwitterSimulation -Dusers=<no-of-concurrent-users> -Dtweets=<no-of-your-tweets> -Dusername=<twitter-user-name> -Dpassword=<twitter-password>
```

*Note*: Keep the concurrent user count between 2 and 5. If you add more load twitter they will display the CAPTCHA login page instead. This is to avoid a [DoS](http://en.wikipedia.org/wiki/Denial-of-service_attack) attack. In other words the login test may fail intermittently based on how many times you run the test.

This script gets you to twitter.com and posts with username, password and authenticity token that is get generated when you request twitter.com.

You can extract values from the HTTP response like this:

```scala
val authenticity_token = regex("""input type="hidden" value="([^"]*)"""").saveAs("authenticity_token")
```

With the response from the HTTP post, it verifies the http status code and the content of the body using bodyString()and regex() utility methods. It also logs-out from the site.

Real users usually reads the pages and clicks through the links. To get this real user simulation, there is a [pause()](https://github.com/excilys/gatling/wiki/Structure-Elements#wiki-pause) method that can be used for this purpose. There are other [structural elements](https://github.com/excilys/gatling/wiki/Structure-Elements) available.

The project has two more tests – basic and advanced simulation. Take a look at and run them in the same way as twitter one.

Gatling automatically handles http headers and cookies. It also auto redirects based on headers, which makes testing sessions and OAuth based applications easier.

Testing a RESTful service layer is mush easier with a script than using the GUI.
Here is nice blog post on how Gatling is used to test the [Neo4j REST](http://maxdemarzi.com/2013/02/14/neo4j-and-gatling-sitting-in-a-tree-performance-t-e-s-t-ing/) interface.

To test the SOAP interface, I may use [SoapUI](http://www.soapui.org/Getting-Started/load-testing.html), which handles most of the SOAP plumbing. You can use Gatling to load test SOAP as well, however you will have to write the SOAP headers and xml body yourself.

*Note*: Gatling 2.x undertook major [API](https://github.com/excilys/gatling/wiki/Gatling-2) refactoring and is not compatible with Gatling 1.x. You may want to watch out for this. I am using version 2.0.0-M3 in all my examples.

There are other tools that support scripting like Beanshell, Python, Clojure and Erlang. But they are not simple to use and learn like Gatling.

#### Maintainability

A script is always easier to modify as a project evolves than maintaining a GUI based load test file. A script also fits very well into your daily workflow as it integrates very well with developer tools like maven, jenkins and your favorite [IDE](https://github.com/excilys/gatling/wiki/Ide-integration).

#### Reporting
Gatling generates nice and easy to understand [static reports](https://github.com/excilys/gatling/wiki/Reports) with metrics, which easily can be shared with anyone on your team. The reports are static and can be run with the daily build or when you release your application. You can then compare the results between each release to monitor how the app is performing.
You can also send the simulation data to [Graphite](https://github.com/excilys/gatling/wiki/Graphite) which gives you live statistics.

#### Integration with other tools and IDEs
Gatling integrates with other tools of your choice (which supports scala) like [maven](https://github.com/excilys/gatling/wiki/Maven-plugin) and eclipse (or Intelli J) to integrate with your daily workflow. Thus, you don’t have to use another tool to load test your app. There is also a [Jenkins plugin](https://github.com/excilys/gatling/wiki/Jenkins-Plugin) available.

#### Underlying Technologies
Gatling uses [actor model](http://en.wikipedia.org/wiki/Actor_model) and doesn’t require 1 thread per user like [JMeter](http://jmeter.apache.org/). This is one of the main reasons that JMeter tends to choke on a high load scenario.

Gatling is built on [Akka actors](http://akka.io/) to handle large-scale tests and Scala’s DSL capability to build clean and simple scripts. It also uses [asynchronous http client](https://github.com/AsyncHttpClient/async-http-client) and non-blocking IO libraries ([Netty](http://netty.io/), [Grizzly](http://grizzly.java.net/)).

#### Conclusion
Gatling is definitely a nice tool to have under your belt. Check out their [wiki](https://github.com/excilys/gatling/wiki) and [soucecode](https://github.com/excilys/gatling). It has great documentation.

Thanks to [@whittierta](https://twitter.com/whittierta) for proofreading and suggestions.



