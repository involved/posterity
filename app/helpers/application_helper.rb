module ApplicationHelper
  include Posterity::Helpers::ApplicationHelper
  def ujs_func
    "javascript:void(0)"
  end
end
