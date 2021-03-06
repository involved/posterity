class Posterity::PostsController < ApplicationController

  def index
    if params[:resources] && defined?(params[:resources].classify)
      post_model = Kernel.const_get(params[:resources].classify)
      posts = post_model.published

      posts = posts.published_in(params[:year], params[:month], params[:day]) if params[:year]
      posts = posts.written_by(params[:author]) if params[:author]
      posts = posts.tagged(CGI.unescape(params[:tag])) if params[:tag]

      posts = posts.page(params[:page]) if defined?(Kaminari)

      instance_variable_set("@#{params[:resources]}", posts)
      render "#{params[:resources]}/index"
    elsif params[:resources]
      throw Posterity::PostModelNotFound.new(params[:resources].classify)
    else
      throw Posterity::PostModelNotSpecified.new
    end
  end

  def show
    post_model = Kernel.const_get(params[:resources].classify)
    if params[:permalink]
      post = post_model.first(:conditions => {:permalink => params[:permalink]})
      redirect_to :controller => "posterity/posts", :action => "show", :year => post.published_at.year, :month => post.published_at.month, :day => post.published_at.day, :id => post.slug
    else
      posts = post_model.first(:conditions => {:slug => params[:id]})
      if !posts.nil?
        instance_variable_set("@#{params[:resources].singularize}", posts)
        render "#{params[:resources]}/show"
      else
        render_404
      end
    end
  end
end
