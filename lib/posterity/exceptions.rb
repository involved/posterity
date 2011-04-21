module Posterity
  class Error < StandardError; end

  class PostModelNotSpecified < Error
    def to_s
      "No post model was specified. Try adding a `blog_for :posterity_model_name` to your routes files."
    end
  end

  class PostModelNotFound < Error
    def initialize(model_name)
      @model_name = model_name
    end
    def to_s
      "Specified model '#{@model_name}' not found in application."
    end
  end
end

