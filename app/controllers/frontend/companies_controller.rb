# frozen_string_literal: true

class Frontend::CompaniesController < FrontendController
  def index
    @top_companies = Company
                     .group(:id)
                     .includes(:logo_attachment)
                     .order('avg(comments_count + likes_count + views_count) desc')
                     .limit(3)
    @categories = Category.friendly.find('companies').children.includes(:children)
  end

  def category
  end
end
