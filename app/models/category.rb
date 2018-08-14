# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId

  has_one_attached :logo
  has_many :posts, class_name: 'AbstractPost', dependent: :destroy
  has_many :menus, dependent: :nullify
  has_many :companies
  acts_as_tree
  scope :active, -> { where(enable: true) }
  friendly_id :title, use: :slugged
  attribute :remove_logo, :boolean
  # attr_accessible :name, :parent_id

  after_save -> { logo.purge }, if: :remove_logo

  def parent_enum
    Category.where.not(id: id).map { |c| [c.title, c.id] }
  end

  def should_generate_new_friendly_id?
    slug.blank? || (title_changed? && !slug_changed?)
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:ukrainian).normalize.to_s
  end
end
