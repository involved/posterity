class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # prevents robot indexing
  def no_index
    @no_index = true
  end
end
