class Manage::ManageController < InheritedResources::Base
  include Posterity::Controllers::Manage::ManageController
  before_filter :no_index
end
