# frozen_string_literal: true

class Article < AbstractPost
  extend FriendlyId
  friendly_id :title, use: :slugged
end
