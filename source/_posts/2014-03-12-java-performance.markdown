---
layout: post
title: "Java Performance"
date: 2014-03-12 21:20:11 -0600
comments: true
categories: Performance
published: false
---

Notes from Java Performance lession

Lesson 1: JVM Overview

1) From Java 7u21, there is server JRE available for UNIX 64 bit OSes. It has got it everything jdk has, except no browser plug-in, no auto updater.

2) Understand the major components of a modern Java Virtual Machine
	- HotSpot VM runtime
	- Garbage collector/ memory manager
		- Generational GC - it partitions the Java heap into two or more regions / generations
			- Young vs Old
		- Permanant Generation - Holds class data structures
			- In Java 8 - it has been eliminated in favor of a meta-space	
	- JIT Compiler
		- generate native byte code
		- Client mode
		- Server mode
		- Tiered - Default In Java 8 - enabled via -XX:+TieredCompilation

3) runtime subsystem
	-XX:+PrintFlagsFinal		
	-XX:+PrintGCDetails
4) Understand the memory management garbage collection (GC) subsystem
	-jvisualvm
		- install plug-in visual GC
		- install memory-pool plugin from https://java.net/projects/memorypoolview
		- Once objects reaches 15 max tenuring, will promoted to old gen space
	- JIT compier subsystem
		- Look at code cache from memory-pool plugin for JIT compilation 

Lesson 2: Collecting Performance Statistics

2.1 Understand the importance of a methodology
	
2.2 Understand which operating system metrics to monitor
	2.2.a Understand which operating system metrics to monitor: Monitor metrics on Windows
		You can monitoring CPU, Memory, Network:
		1) GUI Tool: Performance Monitor
		2) CMD Tool: typeperf

	2.2.b Understand which operating system metrics to monitor: Monitor metrics on Linux
		1) GUI Tool: System Monitory in Ubuntu
		2) CMD tool: vm_stat <interval>
					 mpstat -P ALL
					 top 
		Monitor the CPU Scheduler Run Queue
			use vmstat to monitor run queue
		Monitor High Voluntary Context Switching
			Can indicate Java application that are experiencing lock contention
				- diffuculties in scaling
			1) use pidstat to monitor (need sysstat package required)	
				ex: pidstat -w -I -t -p <pid> <interval>
		Monitor network
			use nicstat
		Monitor disk/io
			use iostat
2.3 Understand what JVM metrics to monitor
	Important JVM metrics:
	- Garbage collection:
		use PrintGCDetails to log gc details
		you can also use -XX:+PrintGCDateStamps	or -XX:+PrintGCTimeStamps - gives point and time when the gc has occurred
		use -Xloggc=/somepath/gc.log - to log gc log
	- Monitor app exectution time and stopped time
		use XX:+PrintGCApplicationStoppedTime and PrintApplicationConcurrentTime
	- Other to consider but not necessarily required
		JIT compilation:
			-XX:+PrintCompilation, -XX:+PrintInlining - these flags are not generally used.
		Fine tune JVM heap space sizes:
			-XX:+PrintTenuringDistribution, PrintAdaptiveSizePolicy(Paraller GC or G1 only)
	- Remote monitoring using jstatd
		requires a security manager and security policy file
	- App level metrics to monitor
		begin and end time of a transaction
		Observing app level JMX MBeans especially those that offer performance information
		Java EE container stats:
			available JDBC connections
			Active/Available Threads
			request arrival rate
			request response times
		Build App level stats MBeans	

Lesson 3: Understand HotSpot JVM GC Logs
3.1 Understand how Parallel GC works

3.2 Understand Parallel GC logs

3.3 Understand how CMS GC works
3.4 Understand CMS GC logs

3.5 Understand how G1 GC works
3.6 Understand G1 GC logs

Lesson 4: Tune the HotSpot JVM Step-by-Step
4.1 Create a plan of attack
	Throughput vs Latency vs Footprint - 
4.2 Understand the step-by-step process
4.3 Determine memory footprint size
4.4 Tune for latency / responsiveness
	Tools to help visualize gc pause times: gchisto, censum from jclarity.com
4.5 Tune for throughput
	-XX:+AggresiveOpts to turn on aggressive gc optimizations.


http://www.nbl.fi/~nbl97/java/tuning/jvm_internals.pdf
http://java.ociweb.com/mark/other-presentations/JavaGC.pdf

http://www.oracle.com/technetwork/java/javase/tech/index-jsp-136373.html
http://www-01.ibm.com/support/docview.wss?uid=swg27013456&aid=1

https://secure.trifork.com/dl/qcon-newyork-2012/slides/5.%20ExtremeJavaPerformanceQConNYC.pdf

http://www.infoq.com/articles/book-java-performance
http://www.infoq.com/presentations/Extreme-Performance-Java

