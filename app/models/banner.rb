class Banner < ApplicationRecord
  enum banner_position: %i[left_top left_bottom]
  has_one_attached :image
end
