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

      base.slug :title

      base.validates_presence_of :title
      base.validates_presence_of :author

      base.before_save :update_author_param
    end

    module ClassMethods
      # Need some scopes here for tagged and archived posts
      def tagged(tags)
      end

      def written_by(author)
        where(:author_param => author.parameterize)
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

      private
      def update_author_param
        self.author_param = self.author.parameterize
      end
    end
  end
end
