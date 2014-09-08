---
layout: post
title: "Panamax template for couchbase 5 node cluster"
date: 2014-09-08 15:29:30 -0600
comments: true
categories: [Panamax, Docker]
---

Panamax is Docker Management for Humans. You can get started with simple steps described [here](http://panamax.io/get-panamax/). It provides a friendly interface for users of Docker, Fleet & CoreOS. With Panamax, you can easily create, share and deploy any containerized app no matter how complex it might be. You can linking (or stitching them) different docker images together and exposing them to outside world. You can start and stop docker containers everything within panamax web ui. 

I have created "Panamax template for couchbase 5 node cluster". Let's see how simple it is to setup the cluster.

<!-- more -->

Most of the steps taken from [here](http://blog.abhinav.ca/blog/2014/07/31/kickstart-a-couchbase-cluster-with-docker). I just made a panamax template.

#### Step 1 : Login into coreOS

``` panamax ssh ```

#### Step 2: Run the blow command from coreOS
  ``` docker ps ```

  ``` for name in dustin_couchbase_{1..4}; do docker inspect -f '{{ .NetworkSettings.IPAddress }}' $name; done ```

  It will give you 4 IP address:
  
  * 172.17.36.140
  * 172.17.36.139
  * 172.17.36.142
  * 172.17.36.141

#### Step 3: Open new terminal and run all these commands in host OS (where your Virtual box running)


  ``` VboxManage controlvm panamax-vm natpf1 rule1,tcp,,8091,,8091 ```
  ``` VboxManage controlvm panamax-vm natpf1 rule2,tcp,,8092,,8092 ``` 
  ``` VboxManage controlvm panamax-vm natpf1 rule3,tcp,,11210,,11210 ``` 

  Note: If you are not clear why you have to do this, here is [panamax wiki](https://github.com/CenturyLinkLabs/panamax-ui/wiki/How-To%3A-Port-Forwarding-on-VirtualBox) that explains in detail.

#### Step 4: Go to (couchbase admin web console)
  http://localhost:8091/

 Login with <br/>
  - ```Username:``` Administrator <br/>
  - ``` Password:``` password

#### Step 5: Go to "Server Nodes"
  Add servers by IP address (Ref# Step: 2)

### More resources to follow:
- [Twitter @panamax_io](https://twitter.com/panamax_io)
- [panamax documentation](http://panamax.io/documentation/)
- [panamax wiki](https://github.com/CenturyLinkLabs/panamax-ui/wiki)
- [Installing Panamax videos](https://www.youtube.com/watch?v=15IKkYCfymk) by https://twitter.com/cardmagic
- [Introduction to Panamax from CenturyLink](http://www.slideshare.net/cardmagic/introduction-to-panamax-from-century-link)


