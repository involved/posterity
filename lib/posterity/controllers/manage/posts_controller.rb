module Posterity
  module Controllers
    module Manage
      module PostsController
        def self.included(base)
          base.extend(ClassMethods)
        end
        
        def create
          create! do |success, failure|
            success.html do
              resource.publish! if params.has_key?(:publish) && resource.is_draft?
              redirect_to collection_url
            end
          end
        end

        def update
          update! do |success, failure|
            success.html do
              resource.publish! if params.has_key?(:publish) && resource.is_draft?
              redirect_to collection_url
            end
          end
        end

        def publish
          @post = Post.with_slug(params[:post_id])
          @post.publish!
          redirect_to manage_posts_url
        end

        def unpublish
          @post = Post.with_slug(params[:post_id])
          @post.draft!
          redirect_to manage_posts_url
        end

        def resource
          @post = Post.first(:conditions => {:slug => params[:id]})
        end

        def collection
          @drafts = Post.drafts
          @posts = Post.published.paginate :page => params[:page], :per_page => 15
        end
        
        module ClassMethods
          
        end
      end
    end
  end
end