class Post < ActiveRecord::Base
  acts_as_taggable
  has_friendly_id :title, :use_slug => true
  scope :published, lambda { where("published_at <= ?", Time.zone.now).order("published_at desc") }
    
  validates_presence_of :title, :author, :content
end
