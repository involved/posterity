class Posterity::PostsController < ApplicationController

  def index
    if params[:posterity_model_name] && defined?(params[:posterity_model_name].classify)
      post_model = Kernel.const_get(params[:posterity_model_name].classify)
      posts = post_model.published

      # refine criteria, based on supplied params
      # if params[:tags]
      # if params[:year]
      # if params[:month]
      # if params[:day]
      # if params[:written_by]

      # posts.paginate(params[:per_page])

      instance_variable_set("@#{params[:posterity_model_name]}", posts)
    elsif params[:posterity_model_name]
      throw Posterity::PostModelNotFound.new(params[:posterity_model_name].classify)
    else
      throw Posterity::PostModelNotSpecified.new
    end
  end

  def show
    post_model = Kernel.const_get(params[:posterity_model_name].classify)
    posts = post_model.first(:conditions => {:slug => params[:id]})
    instance_variable_set("@#{params[:posterity_model_name].singularize}", posts)
  end
end
