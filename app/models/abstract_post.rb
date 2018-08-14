# frozen_string_literal: true

class AbstractPost < ApplicationRecord
  self.table_name = 'posts'
  extend FriendlyId
  include Commentable
  include Likeable

  paginates_per 10
  friendly_id :title, use: :slugged

  scope :active, -> { where(enabled: true) }

  belongs_to :user, optional: true
  belongs_to :category
  has_many_attached :images
  has_many :views, as: :viewable

  attribute :remove_images, :json
  after_save :delete_images, if: -> { remove_images.present? }

  validates :body, presence: true

  def slug_candidates
    [
      :title,
      %i[title id]
    ]
  end

  def delete_images
    images.each_with_index { |_, index| images[index].purge if remove_images.include?(index.to_s) }
  end
end
