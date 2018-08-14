# frozen_string_literal: true

class Frontend::BannersController < FrontendController
  def next
    now = Time.zone.now
    @banner = Banner
              .where('start_date < ?', now)
              .where('end_date > ?', now)
              .order(views: :asc)
              .find_by(banner_position: params[:position])
    @banner&.increment! :views
  end
end
