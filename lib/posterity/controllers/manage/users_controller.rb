module Posterity
  module Controllers
    module Manage
      module UsersController
        def self.included(base)
          base.extend(ClassMethods)
        end
        
        def collection
          @users = User.all
        end
        
        def resource
          @user = User.first(:conditions => {:slug => params[:id]})
        end
        
        module ClassMethods
          
        end
      end
    end
  end
end