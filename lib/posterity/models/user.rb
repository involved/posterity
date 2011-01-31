module Posterity
  module Models
    class User
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Slug

      field :first_name, :type => String
      field :last_name, :type => String
      field :roles, :type => String
      
      devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
      validates_presence_of :first_name, :last_name, :email
      slug :first_name, :last_name
      
      def to_s
        "#{first_name} #{last_name}"
      end

      def has_role?(named)
        roles.split(",").include?(named) if roles
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

      def avatar_url
        nil
      end
      
    end
  end
end