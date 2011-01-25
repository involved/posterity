class Post < ActiveRecord::Base
  acts_as_taggable
  has_friendly_id :title, :use_slug => true
  
  scope :drafts, lambda { where("published_at IS NULL").order("published_at desc") }
  scope :published, lambda { where("published_at <= ?", Time.zone.now).order("published_at desc") }
    
  validates_presence_of :title, :author, :content
  
  def is_draft?
    self.published_at == nil
  end
  
  def publish!
    self.published_at = Time.now
    self.save!
  end
  
  def draft!
    self.published_at = nil
    self.save!
  end
end
