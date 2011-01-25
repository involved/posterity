class PostsController < ApplicationController
  
  def index
    @posts = Post.published
    @posts = @posts.where("published_at >= ?", Date.parse([params[:year], params[:month] || "1", params[:day] || "1"].join("-") )).where("published_at < ?", Date.parse([(params[:year].to_i + 1).to_s, params[:month] || "1", params[:day] || "1"].join("-") )) if params[:year]
    @posts = @posts.tagged_with(CGI.unescape(params[:tag])) if params[:tag]
    @posts = @posts.paginate :page => params[:page], :per_page => 10
  end
  
  def show
    @post = Post.find(params[:id])
    redirect_to posts_path unless @post
  end
end