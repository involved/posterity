module Posterity
  module Models
    class Attachment
      require 'carrierwave/orm/mongoid'
      include Mongoid::Document
      include Mongoid::Timestamps
            
      field :image, :type => String
      
      validates_presence_of :image
      mount_uploader :image, ImageUploader
      
      
      class << self
        def recent
          desc(:created_at).limit(10)
        end
      end
    end
  end
end