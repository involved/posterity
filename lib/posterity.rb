module Posterity
  autoload :Exceptions, 'posterity/exceptions'
  autoload :Post, 'posterity/post'
end
require 'posterity/routes'
require 'posterity/engine'

ActionDispatch::Routing::Mapper.send(:include, Posterity::Routes)
