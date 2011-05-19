module Posterity
  module Routes
    def blog_for(path, *args)
      options = args.extract_options!
      options[:resources] ||= path
      options[:scope] ||= nil
      options[:controller] ||= 'posterity/posts'

      index_path = path.to_s
      if index_path == index_path.singularize
        index_path = "all_#{index_path}"
      end

      match "#{path}" => "#{options[:controller]}#index", :as => index_path, :resources => options[:resources].to_s
      match "#{path}/:year/:month/:day/:id" => "#{options[:controller]}#show", :as => path.to_s.singularize, :resources => options[:resources].to_s
      match "#{path}/written_by/:author" => "#{options[:controller]}#index", :as => "#{path}_written_by", :resources => options[:resources].to_s
      match "#{path}/tagged/:tag" => "#{options[:controller]}#index", :as => "#{path}_tagged", :resources => options[:resources].to_s
      match "#{path}/permalink/:permalink" => "#{options[:controller]}#show", :as => "#{path.to_s.singularize}_permalink", :resources => options[:resources].to_s
      match "#{path}/:year/:month/:day" => "#{options[:controller]}#index", :as => "#{path}_archive", :resources => options[:resources].to_s
      match "#{path}/:year/:month" => "#{options[:controller]}#index", :as => "#{path}_archive", :resources => options[:resources].to_s
      match "#{path}/:year" => "#{options[:controller]}#index", :as => "#{path}_archive", :resources => options[:resources].to_s
    end
  end
end
