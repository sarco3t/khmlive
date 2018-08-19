# frozen_string_literal: true

class Article < AbstractPost
  extend FriendlyId
  friendly_id :title, use: :slugged

  def main_image_path
    images.present? ? images.first : '/assets/default_article.jpg'
  end
end
