class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category

  has_many_attached :images

  attribute :remove_images, :json
  after_save :delete_images, if: -> { remove_images.present? }

  def delete_images
    images.each_with_index { |_, index| images[index].purge if remove_images.include?(index.to_s) }
  end

end
