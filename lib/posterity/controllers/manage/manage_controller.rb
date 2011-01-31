module Posterity
  module Controllers
    module Manage
      module ManageController
        def self.included(base)
          base.extend(ClassMethods)
          base.layout 'manage'
          base.before_filter :authenticate_user!
        end

        # Override redirects after resource creation
        def create
          create! do |success, failure|
            success.html { redirect_to collection_url }
          end
        end

        # Override redirects after resource update
        def update
          update! { collection_url }
        end
        
        module ClassMethods
          
        end
      end
    end
  end
end