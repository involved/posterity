module Posterity
  module Post

    def self.included(base)
      base.send :include, Mongoid::Slug
      base.send :include, Mongoid::Taggable
      base.send :include, Mongoid::Publishable

      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)

      base.field :title
      base.field :content
      base.field :author
      base.field :author_param
      base.field :permalink

      base.slug :title

      base.validates_presence_of :title
      base.validates_presence_of :author

      base.before_save :update_author_param
      base.before_create :generate_permalink!
    end

    module ClassMethods
      # Need some scopes here for tagged and archived posts
      def tagged(tags)
        all_in(:tags_array => Array(tags))
      end

      def written_by(author)
        where(:author_param => author.parameterize)
      end

      def published_in(year, month = nil, day = nil)
        if day
          starts_on = Time.utc(year.to_i, month.to_i, day.to_i)
          ends_on = Time.utc(year.to_i, month.to_i, day.to_i + 1)
        elsif month
          day = 1
          starts_on = Time.utc(year.to_i, month.to_i, day.to_i)
          ends_on = Time.utc(year.to_i, month.to_i + 1, day.to_i)
        else
          day = 1
          month = 1
          starts_on = Time.utc(year.to_i, month.to_i, day.to_i)
          ends_on = Time.utc(year.to_i + 1, month.to_i, day.to_i)
        end
        where(:published_at => {"$gte" => starts_on}).and(:published_at => {"$lt" => ends_on}).desc(:published_at)
      end
    end

    module InstanceMethods
      def summary(options = {})
        options[:sentences] ||= 2
        options[:letters] ||= 140

        sentences = self.content.split(".").compact[0...options[:sentences]].map{ |sentence| sentence = sentence.rstrip; sentence += ". " if sentence.length > 0 }
        while(sentences.join("").length > options[:letters] && sentences.length > 1) do
          sentences.pop
        end

        sentences[0] = sentences[0].truncate(options[:letters]) if sentences[0]

        sentences.join("").html_safe
      end

      protected
      def generate_permalink!
        self.permalink = ActiveSupport::SecureRandom.hex(4)
        while self.class.first(:conditions => {:permalink => self.permalink}) do
          self.permalink = ActiveSupport::SecureRandom.hex(4)
        end
      end

      private
      def update_author_param
        self.author_param = self.author.parameterize
      end
    end
  end
end
