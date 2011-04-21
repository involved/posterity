module Posterity
  module Routes
    def blog_for(path, *args)
      options = args.extract_options!
      options[:resources] ||= path
      options[:per_page] ||= 20
      options[:scope] ||= nil

      get "#{path}" => "posterity/posts#index", :as => path, :resources => options[:resources].to_s, :per_page => options[:per_page], :scope => options[:scope]
      get "#{path}/:year/:month/:day/:id" => "posterity/posts#show", :as => path.to_s.singularize, :scope => options[:scope]
      get "#{path}/:year/:month/:day" => "posterity/posts#index"
      get "#{path}/:year/:month" => "posterity/posts#index"
      get "#{path}/:year" => "posterity/posts#index"
      get "#{path}/written_by/:author" => "posterity/posts#index"
      get "#{path}/tagged/:tags" => "posterity/posts#index"
    end
  end
end
