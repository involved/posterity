class Manage::AttachmentsController < Manage::ManageController
  respond_to :js
  
  def create
    create! do |success, failure|
      success.js { render :partial => "attachment", :locals => {:attachment => @attachment} }
      failure.js { "Upload failed" }
    end
  end
end
