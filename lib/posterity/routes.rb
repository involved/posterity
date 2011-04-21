module Posterity
  module Routes
    def blog_for(posterity_model_name, *args)
      options = args.extract_options!
      options[:per_page] ||= 20
      options[:scope] ||= nil

      get "#{posterity_model_name}" => "posterity/posts#index", :as => posterity_model_name, :posterity_model_name => posterity_model_name, :per_page => options[:per_page], :scope => options[:scope]
      get "#{posterity_model_name}/:year/:month/:day/:id" => "posterity/posts#index", :as => posterity_model_name.singularize, :scope => options[:scope]
      get "#{posterity_model_name}/:year/:month/:day" => "posterity/posts#index"
      get "#{posterity_model_name}/:year/:month" => "posterity/posts#index"
      get "#{posterity_model_name}/:year" => "posterity/posts#index"
      get "#{posterity_model_name}/written_by/:author" => "posterity/posts#index"
      get "#{posterity_model_name}/tagged/:tags" => "posterity/posts#index"
    end
  end
end
