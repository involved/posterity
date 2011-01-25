class Manage::PostsController < Manage::ManageController
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
    @post = Post.find(params[:post_id])
    @post.publish!
    redirect_to manage_posts_url
  end
  
  def unpublish
    @post = Post.find(params[:post_id])
    @post.draft!
    redirect_to manage_posts_url
  end
  
  def collection
    @drafts = Post.drafts
    @posts = Post.published.paginate :page => params[:page], :per_page => 15
  end
end
