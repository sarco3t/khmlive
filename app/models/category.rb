class Category < ApplicationRecord
  has_one_attached :logo

  attribute :remove_logo, :boolean
  after_save -> { logo.purge }, if: :remove_logo
end
