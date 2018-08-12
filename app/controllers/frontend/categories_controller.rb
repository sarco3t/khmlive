# frozen_string_literal: true

class Frontend::CategoriesController < FrontendController
  def show; end

  def posters
    @category = Category.friendly.find('posters')
  end

  def ads
    @category = Category.friendly.find('ads')
  end
end
