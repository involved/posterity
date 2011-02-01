class PostsController < ApplicationController
  
  def index
    if params[:year]
      @posts = Post.published_in(params[:year], params[:month], params[:day]) if params[:year]
    elsif params[:tag]
      @posts = Post.tagged_with(CGI.unescape(params[:tag])) if params[:tag]
    else
      @posts = Post.published
    end
    
    #@posts = @posts.where(:author.matches => params[:name].underscore.humanize) if params[:name]
    @posts = @posts.paginate :page => params[:page], :per_page => 10
  end
  
  def show
    @post = Post.with_slug(params[:id])
    redirect_to posts_path unless @post
  end
end
