# Posterity

Posterity is a mongoid model extension that easily allows the
integration of 'blog-like' behaviours into any mongoid document.


# Requirements

Posterity uses the following gems:

* mongoid_slug
* mongoid_taggable
* ?


# Installation

Since this is still a private repo, you must reference the repository in
your gemfile:

    gem 'posterity', :git => 'git@github.com:involved/posterity.git'


# Usage

## Setting up your model

To add necessary article features to your model, just include the
posterity post model in your document, ie:

    # app/models/article.rb
    class Article
      include Mongoid::Document
      include Mongoid::Timestamps
      include Posterity::Post

      #...everthing else you want this model to have...
    end


## Controllers

Posterity provides a frontend controller for accessing posts. Any
content management controllers or views need to be managed by the
developer, and are not provided as part of posterity.

To access this controller, see the next point regarding routes.

Views for this controller should be placed in `app/views/posterity`.
Please note that at this time there are no generators. Your index action
should expect an `@articles` (or whatever your model name was) variable
and your show action an `@article` variable. Both of these names are
based on the route (as specified below).


## Routes

To access the baked-in controller, simply add this line to your routes
file:

    blog_for :articles

Where `:articles` is the name of your post model. This will provide the
following route formats:

    /articles # => index
    /articles/2011/11/28/article-slug-goes-here # => show
    /articles/2011/11/28 # => archive for 28th November, 2011
    /articles/2011/11 # => archive for November, 2011
    /articles/2011 # => archive for 2011
    /articles/tagged/name-of-some-tag # => articles tagged with 'name of some tag'
    /articles/written-by/nicholas-bruning # => articles written by 'nicholas bruning'
