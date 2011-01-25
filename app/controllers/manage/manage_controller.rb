class Manage::ManageController < InheritedResources::Base
  layout 'manage'
  
  before_filter :no_index
  before_filter :authenticate_user!
  
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
end
