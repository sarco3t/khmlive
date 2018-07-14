module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
    has_many :latest_comments, -> { limit(5) }, as: :commentable, class_name: 'Comment'
  end
end
