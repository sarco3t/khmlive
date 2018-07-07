class Article < AbstractPost
  extend FriendlyId
  friendly_id :title, use: :slugged
end
