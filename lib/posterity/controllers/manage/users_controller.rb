module Posterity
  module Controllers
    module Manage
      module UsersController
        def self.included(base)
          base.extend(ClassMethods)
        end
        
        module ClassMethods
          
        end
      end
    end
  end
end