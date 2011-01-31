module Posterity
  module Models
    module Post
      def self.included(base)
        base.extend(ClassMethods)
        
        base.acts_as_taggable
        base.has_friendly_id :title, :use_slug => true

        base.scope :drafts, lambda { base.where("published_at IS NULL").order("published_at desc") }
        base.scope :published, lambda { base.where("published_at <= ?", Time.zone.now).order("published_at desc") }

        base.validates_presence_of :title, :author, :content
      end
      
      def is_published?
        self.published_at != nil
      end

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
      
      module ClassMethods
        def archive_dates
          dates = []
          last_date = nil
          self.published.each do |post|
            normalized_post_date = Date.parse("#{post.published_at.year}-#{post.published_at.month}-1")
            if normalized_post_date != last_date
              dates << {:date => normalized_post_date, :count => 1}
              last_date = normalized_post_date
            else
              dates.last[:count] += 1
            end
          end
          dates
        end
      end
    end
  end
end