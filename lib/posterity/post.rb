module Posterity
  module Post
    include Mongoid::Slug
    include Mongoid::Taggable
    include Mongoid::Publishable

    field :title
    field :content
    field :author

    slug :title

    validates_presence_of :title
    validates_presence_of :author
  end
end
