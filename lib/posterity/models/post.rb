module Posterity
  module Models
    class Post
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Slug
      include Mongoid::Search
      include Mongoid::Taggable
    
      field :title, :type => String
      field :content, :type => String
      field :author, :type => String
      field :published_at, :type => DateTime
    
      slug :title
      tags_separator ','
      enable_tags_index!
      #search_in :tags, :title, :author, :content

      validates_presence_of :title 
      validates_presence_of :author
      validates_presence_of :content
      
      class << self
        def with_slug(slug)
          first(:conditions => {:slug => slug})
        end
        
        def tagged_with(tags)
          any_in(:tags_array => tags.to_a)
        end
        
        def published
          where(:published_at => { "$lte" => Time.now }).desc(:published_at)
        end

        def drafts
          where(:published_at => nil).desc(:published_at)
        end
        
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
      
      def self.archive_dates
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