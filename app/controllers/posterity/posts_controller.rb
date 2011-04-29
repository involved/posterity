class Posterity::PostsController < ApplicationController

  def index
    if params[:resources] && defined?(params[:resources].classify)
      post_model = Kernel.const_get(params[:resources].classify)
      posts = post_model.published

      # refine criteria, based on supplied params
      # if params[:tags]
      # if params[:year]
      # if params[:month]
      # if params[:day]
      posts = posts.written_by(params[:author]) if params[:author]
      posts = posts.tagged_with(CGI.unescape(params[:tag])) if params[:tag]

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
    posts = post_model.first(:conditions => {:slug => params[:id]})
    instance_variable_set("@#{params[:resources].singularize}", posts)
    render "#{params[:resources]}/show"
  end
end
