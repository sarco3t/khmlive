class Company < ApplicationRecord
  extend FriendlyId
  include Commentable
  include Likeable

  paginates_per 10
  friendly_id :title, use: :slugged
  has_one_attached :logo
  scope :active, -> { where(enabled: true) }

  belongs_to :category
  has_many :views, as: :viewable

  def should_generate_new_friendly_id?
    slug.blank? || (title_changed? && !slug_changed?)
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:ukrainian).normalize.to_s
  end

  def address
    ''
  end


end
