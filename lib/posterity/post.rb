module Posterity
  module Post

    def self.included(base)
      base.send :include, Mongoid::Slug
      base.send :include, Mongoid::Taggable
      base.send :include, Mongoid::Publishable

      base.extend(ClassMethods)

      base.field :title
      base.field :content
      base.field :author

      base.slug :title

      base.validates_presence_of :title
      base.validates_presence_of :author
    end

    module ClassMethods
      # Need some scopes here for tagged and archived posts
      def tagged(tags)
      end
    end
  end
end
