class Manage::PostsController < Manage::ManageController
  def publish
    @post = Post.find(params[:post_id])
    @post.update_attributes(:published_at => Time.zone.now)
    redirect_to manage_posts_url
  end
  
  def unpublish
    @post = Post.find(params[:post_id])
    @post.update_attributes(:published_at => nil)
    redirect_to manage_posts_url
  end
  
  def collection
    @posts = Post.all.paginate :page => params[:page], :per_page => 15
  end
end
