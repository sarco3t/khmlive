class Menu < ApplicationRecord
  belongs_to :category, optional: true

  delegate :title, to: :category, prefix: true

  scope :active, -> { where(enabled: true) }

  def category_or_title
    "#{self.category_title || self.title}"
  end
end
