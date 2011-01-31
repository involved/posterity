module Posterity
  module Controllers
    module Manage
      module AttachmentsController
        def self.included(base)
          base.extend(ClassMethods)
          base.respond_to :js
        end
        
        def create
          create! do |success, failure|
            success.js { render :partial => "attachment", :locals => {:attachment => @attachment} }
            failure.js { "Upload failed" }
          end
        end
        
        module ClassMethods
          
        end
      end
    end
  end
end