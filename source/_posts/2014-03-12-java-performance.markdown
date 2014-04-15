---
layout: post
title: "Java Performance"
date: 2014-03-12 21:20:11 -0600
comments: true
categories: Performance
---

Notes from [Java Performance](http://www.informit.com/store/java-performance-livelessons-video-training-downloadable-9780133443554) by Charlie Hunt. Reference [book](http://www.amazon.com/Java-Performance-Charlie-Hunt/dp/0137142528) by Charlie Hunt and Binu John.

#### Lesson 1: JVM Overview
- From Java 7u21, there is [server JRE](http://www.oracle.com/technetwork/java/javase/downloads/server-jre7-downloads-1931105.html) available for UNIX 64 bit OSes. It has got it everything jdk has, except no browser plug-in, no auto updater.

- Understand the major components of a modern Java Virtual Machine
	- HotSpot VM runtime
	- Garbage collector/ memory manager
		- Generational GC - it partitions the Java heap into two or more regions / generations
			- Young vs Old
		- Permanent Generation - Holds class data structures
			- In Java 8 - it has been eliminated in favor of a meta-space	
	- JIT Compiler
		- Generates native byte code
		- Client mode
		- Server mode
		- Tiered - Default In Java 8 - enabled via -XX:+TieredCompilation

- Runtime subsystem
	- `-XX:+PrintFlagsFinal`
	- `-XX:+PrintGCDetails`
- Understand the memory management garbage collection (GC) subsystem
	- jvisualvm
		- Install plug-in visual GC
		- Install memory-pool plug-in from [here](https://java.net/projects/memorypoolview)
		- Once objects reaches 15 max tenuring, will promoted to old gen space
		- [jTop](https://code.google.com/p/hatter-source-code/wiki/jtop)
	- JIT compiler subsystem
		- Look at code cache from memory-pool plug-in for JIT compilation 
---

#### Lesson 2: Collecting Performance Statistics
- Understand the importance of a methodology
- Understand which operating system metrics to monitor
	- Understand which operating system metrics to monitor: Monitor metrics on Windows.
		You can monitoring CPU, Memory, Network:
		1. GUI Tool: Performance Monitor
		2. CMD Tool: `typeperf`

	- Understand which operating system metrics to monitor: Monitor metrics on Linux
		1. GUI Tool: System Monitory in Ubuntu
		- CMD tool: `vm_stat` <interval>
					 `mpstat -P ALL`
					 `top`
		- Monitor the CPU Scheduler Run Queue
			use vmstat to monitor run queue
		- Monitor High Voluntary Context Switching
			- Can indicate Java application that are experiencing lock contention
				- Makes it difficulties in scaling
			- Use `pidstat` to monitor (need `sysstat` package required)	
				ex: `pidstat -w -I -t -p <pid> <interval>`
		Monitor network
			use nicstat
		Monitor disk/io
			use iostat
- Understand what JVM metrics to monitor
	- Important JVM metrics:
	- Garbage collection:
		Use `PrintGCDetails` to log gc details
		you can also use `-XX:+PrintGCDateStamps` or `-XX:+PrintGCTimeStamps` - gives point and time when the gc has occurred
		use `-Xloggc=/somepath/gc.log` - to log gc log
	- Monitor app exectution time and stopped time
		- Use `-XX:+PrintGCApplicationStoppedTime` and `-XX:+PrintApplicationConcurrentTime`
	- Other to consider but not necessarily required
		- JIT compilation: `-XX:+PrintCompilation`, `-XX:+PrintInlining` - these flags are not generally used.
		- Fine tune JVM heap space sizes: `-XX:+PrintTenuringDistribution`, `PrintAdaptiveSizePolicy` (Paraller GC or G1 only)
	- Remote monitoring using `jstatd`
		- Requires a security manager and security policy file
	- App level metrics to monitor:
		- Begin and end time of a transaction
		- Observing app level JMX MBeans especially those that offer performance information
		- Java EE container stats:
			- Available JDBC connections
			- Active/Available Threads
			- Request arrival rate
			- Request response times
		- Build App level stats via `MBeans`. Example is on the book.
---

#### Lesson 3: Understand HotSpot JVM GC Logs
- Understand how Parallel GC works
	- Understand Parallel GC logs 
- Understand how CMS GC works
	- Understand CMS GC logs
- Understand how G1 GC works
	- Understand G1 GC logs

> All of them produces totally different information

---

#### Lesson 4: Tune the HotSpot JVM Step-by-Step
- Create a plan of attack
	- Throughput vs Latency vs Footprint
- Understand the step-by-step process
- Determine memory footprint size
- Tune for latency / responsiveness: 	Tools to help visualize gc pause times: [gchisto](https://java.net/projects/gchisto), [censum](http://www.jclarity.com/censum/) from jclarity.com
- Tune for throughput: `-XX:+AggresiveOpts` to turn on aggressive gc optimizations

## More resources:

- http://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html
- http://www.nbl.fi/~nbl97/java/tuning/jvm_internals.pdf
- http://java.ociweb.com/mark/other-presentations/JavaGC.pdf
- http://www.oracle.com/technetwork/java/javase/tech/index-jsp-136373.html
- http://www-01.ibm.com/support/docview.wss?uid=swg27013456&aid=1
- https://secure.trifork.com/dl/qcon-newyork-2012/slides/5.%20ExtremeJavaPerformanceQConNYC.pdf
- http://www.infoq.com/articles/book-java-performance
- http://www.infoq.com/presentations/Extreme-Performance-Java
- http://www.oracle.com/technetwork/java/javaseproducts/mission-control/index.html
- [Java Language and Virtual Machine Specifications](http://docs.oracle.com/javase/specs/)
- [linux-performance-analysis-and-tools](http://hatter-source-code.googlecode.com/svn/trunk/attachments/wiki/performance/linux-performance-analysis-and-tools.pdf)
- [Study_Java_Diagnosis](https://code.google.com/p/hatter-source-code/wiki/Study_Java_Diagnosis)
- [Java Performance Tuning tool reports](http://www.javaperformancetuning.com/tools/index.shtml)
- [Samurai](http://samuraism.jp/samurai/en/index.html)
- [OSCON2012 TroubleShoot Java](http://people.apache.org/~billa/oscon2012/OSCON2012TroubleShootJava.pdf)

I would highly encourage to read the [book](http://www.amazon.com/Java-Performance-Charlie-Hunt/dp/0137142528) or take the [LiveLessons](http://www.informit.com/store/java-performance-livelessons-video-training-downloadable-9780133443554). Charlie Hunt is awesome!

