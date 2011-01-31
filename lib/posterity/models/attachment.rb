module Posterity
  module Models
    module Attachment
      def self.included(base)
        base.extend(ClassMethods)
        base.mount_uploader :image, ImageUploader
        base.validates_presence_of :image
        base.scope :recent, base.order("created_at desc").limit(10)
      end
      
      module ClassMethods
        # nothing
      end
    end
  end
end