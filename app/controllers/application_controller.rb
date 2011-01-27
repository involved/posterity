class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource
  
  # prevents robot indexing
  def no_index
    @no_index = true
  end
  
  protected
  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end
end
