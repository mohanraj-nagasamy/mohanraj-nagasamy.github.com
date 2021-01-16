---
layout: post
title: "Interesting project: Nashorn"
date: 2014-03-08 20:57:22 -0700
comments: true
tags: Nashorn
---

I am going to cover some of the interesting or [odd projects](http://projectodd.org) that are being targeted to run on JVM that I came across recently in this post blog.


![image-center](http://upload.wikimedia.org/wikipedia/commons/e/ec/Nashorn.Aberdeen.0007wakh.jpg){: .align-right}

#### Nashorn: 
[Nashorn](http://openjdk.java.net/projects/nashorn/) is an upcoming JavaScript engine, developed fully in Java 8 Language by Oracle. And [open sourced](http://openjdk.java.net/projects/nashorn) to OpenJDK as part of jdk8. It also validates the InvokeDynamic ([JSR-292](http://jcp.org/en/jsr/detail?id=292)) feature in JDK 7; leverage all new language and JVM features in JDK 8.

<!-- more -->

We know the existing JVM (from JDK 1.1 onwards) ships with a JavaScript engine, which is called Rhino. But the recent version of [Rhino](https://developer.mozilla.org/en-US/docs/Rhino) has only been tested with JDK 1.4 and grater. I don’t know who in the world is using JDK 1.4 anyway. 

#### So what is need for the new project?

Rhino is an old code base and developed by using old JDK. And Nashorn significantly outperforms Rhino, it may not beat [Google’s V8](http://wnameless.wordpress.com/2013/12/10/javascript-engine-benchmarks-nashorn-vs-v8-vs-spidermonkey). And Nashorn implements a new [meta-object](https://github.com/szegedi/dynalink) protocol that simplifies calling Java APIs from JavaScript and enables seamless interactions between JavaScript and Java.  And all the [JVM TI](http://docs.oracle.com/javase/6/docs/technotes/guides/jvmti) based tools such as debugging and profiling can read meta-object protocol.

But the real motivation for writing a new engine to validate [InvokeDynamic](http://docs.oracle.com/javase/7/docs/api/java/lang/invoke/package-summary.html) feature, which formally opened the door to [support non-Java](http://docs.oracle.com/javase/7/docs/technotes/guides/vm/multiple-language-support.html) languages on JVM. 

Nashorn engine passes ECMAScript 5.1 compliance tests. You can follow [Oracle’s blog](https://blogs.oracle.com/nashorn/) for the updated info. It is an interesting project to checkout.

