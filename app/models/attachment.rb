class Attachment < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  validates_presence_of :image
  
  scope :recent, order("created_at desc").limit(10)
end
