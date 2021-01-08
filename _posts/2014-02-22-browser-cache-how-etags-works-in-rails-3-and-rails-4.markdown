---
layout: post
title: "Browser Cache: How ETags works in Rails 3 and Rails 4"
date: 2014-02-22 15:39:52 -0700
comments: true
tags: [Cache, Performance]
---

Entity tags (ETags) are a mechanism that web/application servers and browsers use to determine whether the entity or component (images, scripts, stylesheets, page content etc) in the browser's cache matches the one on the origin server. 

<!-- more -->

Rails 3 and Rails 4 uses ETags by default and let’s look at how they work first:


![image-center](/assets/images/posts/etags-rails-3-and-rails-4.png){: .align-center}


Lets say you are going to a blog website and requesting a list of posts:

* First Request:
	- Browser makes the initial first request
* First Response:
	- Rails creates response body 
	- Rails creates ETag 
	- Rails responds with ETag header, status code 200 

The browser caches the response now. When the browser makes subsequent request, here is the flow:

* Subsequent Request:
	- Browser makes request with header ‘If-None-Matched’ with ETag value from the initial request. 
* Subsequent Response:
	- Rails creates body and creates ETag
	- Compares ETag value with ‘If-None-Matched’ value
	- If ETag match then response body is not included in response and returns with 304 Not Modified status
	- If ETag doesn’t match then body is included in the response and ETags are included in header

#### Advantage
So what’s the advantage when ETag matches with the one on the server? The Rails doesn’t send the body content as part of the response. So the response is small and fast to travel on the network. The browser loads the contents from the browser cache instead which makes website faster.

##### Enable ETag
So what you have to do to enable ETag chache? Nothing. You don’t have to do anything to take advantage of ETag cache.

The below code uses Rails default ETag cache:

``` ruby

class PostsController < ApplicationController
def show
    @post = Post. find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

end

```

So how do rails generate ETags? Well, it will render the response and generates the ETags from the response body.
The code may look like something like this in rails:

```
headers['ETag'] = Digest::MD5.hexdigest(body)
```

#### Custom ETags
It is not a good idea to process the entire response body everytime to generate ETag. Generating entire response body involves calling the DB to fetch all the related data and processing html templates and partial page renderings. This is a costly process. 
How do you solve this issue? You have fresh_when and stale? rails cache helper come in handy to rescue you.

The code will look like this with fresh_when and stale?:

``` ruby
class PostsController < ApplicationController
  def show
    @post = Post. find(params[:id])
    if stale? @post
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    fresh_when @post
  end

end
```

So how do rails generate ETags now? The code may look like something like this in rails for stale? and fresh_when helpers:

```
headers['ETag'] = Digest::MD5.hexdigest(@post.cache_key)
```

Cache_key is combination of ```model_name/model.id-model.updated_at```. It will be like this for Post model: ```post/123-201312121212```

##### When do you use fresh_when and stale? cache helper and what’s difference?
If you have special response processing like the one in show method, then use stale? helper. If you don’t have any special response processing like the one in edit method and using default-rendering mechanism (i.e. you’re not using respond_to or calling render yourself) then use fresh_when.

#### Customize ETag generation
If you cache based on ```current_user or current_customer```, you can pass multiple arguments to generate ETag. The arguments have to be a Hash.

The sample code will look like:

``` ruby
class PostsController < ApplicationController
  def show
    @post = Post. find(params[:id])
    if stale? @post, current_user_id: current_user.id
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    fresh_when @post, current_user_id: current_user.id
  end

  def recent
    @post = Post.find(params[:id])
    fresh_when @post, current_user_id: current_user.id
  end

end
```

#### Rails 4
When look at edit and recent methods, there are some repetitions. How do we DRY it up? That’s when Rails 4 declarative ETags comes into play.

Rails 3 and Rails 4 uses ETags by default for browser caching. But Rails 4 has a feature called declarative ETags, which allows you to add additional controller-wide information when generating an ETag.

Let’s look at how to apply Rails 4 declarative ETags to the above code:

``` ruby
class PostsController < ApplicationController
etag { current_user.id }
  def show
    @post = Post. find(params[:id])
    if stale? @post
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    fresh_when @post
  end

  def recent
    @post = Post.find(params[:id])
    fresh_when @post
  end

end
```

You can have multiple declarative ETags like this:

``` ruby
class PostsController < ApplicationController
  etag { current_user.id }
  etag { current_customer.id }
.
.
.
end
```

You can have conditions inside declarative ETags like this one to run them only on certain actions:

``` ruby
class PostsController < ApplicationController
  etag do
    { current_user_id: current_user.id } if %w(show edit).include? params[:action]
  end
end
```

Declarative ETags doesn’t support :only, :if options yet like one we have on before_filter/before_action or after_filer/after_action to run call back only on certain actions. 

#### Resouces
* [http://blog.remarkablelabs.com/2012/12/generate-controller-wide-etags-rails-4-countdown-to-2013](http://blog.remarkablelabs.com/2012/12/generate-controller-wide-etags-rails-4-countdown-to-2013)
* [http://www.upgradingtorails4.com/](http://www.upgradingtorails4.com/)
* [http://guides.rubyonrails.org/caching_with_rails.html](http://guides.rubyonrails.org/caching_with_rails.html)
* [https://devcenter.heroku.com/articles/http-caching-ruby-rails#conditional-cache-headers](https://devcenter.heroku.com/articles/http-caching-ruby-rails#conditional-cache-headers)
