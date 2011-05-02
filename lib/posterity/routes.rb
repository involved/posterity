module Posterity
  module Routes
    def blog_for(path, *args)
      options = args.extract_options!
      options[:resources] ||= path
      options[:scope] ||= nil

      match "#{path}" => "posterity/posts#index", :as => path, :resources => options[:resources].to_s
      match "#{path}/:year/:month/:day/:id" => "posterity/posts#show", :as => path.to_s.singularize, :resources => options[:resources].to_s
      #get "#{path}/:year/:month/:day" => "posterity/posts#index", :as => path, :resources => options[:resources].to_s
      #get "#{path}/:year/:month" => "posterity/posts#index", :as => path, :resources => options[:resources].to_s
      #get "#{path}/:year" => "posterity/posts#index", :as => path, :resources => options[:resources].to_s
      match "#{path}/written_by/:author" => "posterity/posts#index", :as => "#{path}_written_by", :resources => options[:resources].to_s
      match "#{path}/tagged/:tag" => "posterity/posts#index", :as => "#{path}_tagged", :resources => options[:resources].to_s
      match "#{path}/permalink/:permalink" => "posterity/posts#show, :as => #{path}_permalink", :resources => options[:resources].to_s
    end
  end
end
