class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  
  def to_s
    "#{first_name} #{last_name}"
  end
  
  def has_role?(named)
    roles.split(",").include?(named)
  end
  
  def is_su?
    has_role?("su")
  end
  
  def is_manager?
    has_role?("manager")
  end
  
  def is_editor?
    has_role?("editor")
  end
  
  def is_author?
    has_role?("author")
  end
  
  def role_options
    ["manager", "editor", "author"]
  end
end
