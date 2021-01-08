---
layout: post
title: "Blocks in Java Lang"
date: 2014-02-23 18:29:28 -0700
comments: true
tags: Java
---

We all love blocks in Ruby. Wouldn’t it be great if Java Lang had support for blocks? Well, Java Lang will support [blocks/lambdas](http://openjdk.java.net/projects/lambda/) in [jdk8](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html), but in a limited way.

Until you get a chance to work with [jdk8](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html) for real blocks/lambdas, there is an old trick we can apply while creating/initializing an object. That is called the less known [“Double Brace Initialization”](http://c2.com/cgi/wiki?DoubleBraceInitialization) java idiom. This just works for **creating/initializing an object**. You can’t apply this idiom in other places like you would in Ruby. But, this trick works in all the version of java as well including java 1.2

<!-- more -->

Let’s say you have the following class and want to create a list of valid order statuses:

`OrderStatus.java`
``` java 
public class OrderStatus {
    private String code;
    private String description;
 
    OrderStatus(String code, String description) {
        this.code = code;
        this.description = description;
    }
 
    public OrderStatus() {
    }
 
    String getCode() {
        return code;
    }
 
    void setCode(String code) {
        this.code = code;
    }
 
    String getDescription() {
        return description;
    }
 
    void setDescription(String description) {
        this.description = description;
    }
 
 
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
 
        OrderStatus that = (OrderStatus) o;
 
        if (code != null ? !code.equals(that.code) : that.code != null) {
            return false;
        }
        if (description != null ? !description.equals(that.description) : that.description != null) {
            return false;
        }
 
        return true;
    }
 
    @Override
    public int hashCode() {
        int result = code != null ? code.hashCode() : 0;
        result = 31 * result + (description != null ? description.hashCode() : 0);
        return result;
    }
}
```

First you would create something like this:

``` java
final static Set<OrderStatus> VALID_ORDER_STATUSES = new HashSet<OrderStatus>();
```

And you would create a static block and add the valid order statuses:

``` java
static {
    VALID_ORDER_STATUSES.add(new OrderStatus("01", "Order Placed"));
    VALID_ORDER_STATUSES.add(new OrderStatus("02", "Order Processed"));
    VALID_ORDER_STATUSES.add(new OrderStatus("03", "Order Cancelled"));
    VALID_ORDER_STATUSES.add(new OrderStatus("04", "Order Failed"));
}
```

Wouldn’t be great if we can combine into one step? Well, we can do by using Double Brace Initialization. Let’s see how it would look:

``` java
final static Set<OrderStatus> VALID_ORDER_STATUSES_WITH_DOUBLE_BRACE = new HashSet<OrderStatus>() { {
        tadd(new OrderStatus("01", "Order Placed"));
        tadd(new OrderStatus("02", "Order Processed"));
        tadd(new OrderStatus("03", "Order Cancelled"));
        tadd(new OrderStatus("04", "Order Failed"));
        } };
```

This code is completely valid and works in **all the versions of java**. You may wonder what is going on here.


The first brace creates **anonymous inner/sub class** that extends HashSet and the second one declares **instance initializer**. The inner class doesn’t add new instance variables, but it contains an initializer block.

Let’s see how we can apply this trick while creating *OrderStatus* with default constructor, not using two params constructor.

``` java
private static OrderStatus INVALID_ORDER_STATUS = new OrderStatus() { {
        setCode("XX");
        setDescription("Invalid");
        } };
```

You have to note that if you create a new object with the same order status code and description is **not exactly equal** to the one you created.

The condition would be false in equals() methods:

``` java
if (o == null || getClass() != o.getClass()) {
        return false;
}
```

Let's say you are creating a new:

``` java
private static OrderStatus INVALID_ORDER_STATUS = new OrderStatus() { {
        setCode("XX");
        setDescription("Invalid");
        } };

private static OrderStatus INVALID_ORDER_STATUS_2 = new OrderStatus() { {
        setCode("XX");
        setDescription("Invalid");
        } };
```

`INVALID_ORDER_STATUS.equals(INVALID_ORDER_STATUS_2)` and `INVALID_ORDER_STATUS.equals(INVALID_ORDER_STATUS_3)` will return false, because it has different anonymous class.

Collection classes should be fine if you create objects like the one we created. `VALID_ORDER_STATUSES_WITH_DOUBLE_BRACE.contains(new OrderStatus("01", "Order Placed"))` will return true.

You can use the same trick, if you want to call some methods just after creating an object like this:

```java
Action action = new Action() { {
        step1();
        step2();
        } };
String result = action.result();
System.out.println("action result = " + result);
```

And, you can use this idiom while passing object as a parameter.

``` java
valideOrderStatues(new HashSet<OrderStatus>() { {
                    add(new OrderStatus("01", "Order Placed"));
                    add(new OrderStatus("02", "Order Processed"));
                    add(new OrderStatus("03", "Order Cancelled"));
                    add(new OrderStatus("04", "Order Failed"));
            } });

```


It just makes your code more concise. Try to use wherever it makes sense. All the code is in [github](https://github.com/mohanraj-nagasamy/DoubleBrace/).

