# frozen_string_literal: true

class Frontend::PagesController < FrontendController
  layout 'frontend'

  def home
    session[:geo] ||= begin
      res = Geocoder.search(ip).first
      {
        'loc' => res.data['loc'],
        'city' => res.city
      }
    rescue StandardError
      @weather = {}
      {}
    end
    p session[:geo]
    @weather = Rails.cache.fetch("weather#{session[:geo]['city']}", expires_in: 2.hours) do
      weather = OpenWeather::Current.geocode(*session[:geo]['loc'].split(','), options)
      main =weather['weather'].class == Array ? weather['weather'].first : weather['weather']
      {
        icon: main['icon'],
        main: main['main'],
        min: weather['main']['temp_min'].to_i,
        max: weather['main']['temp_max'].to_i
      }
    end
  end

  private

  def ip
    Rails.env.production? ? request.remote_ip : '46.63.46.163'
  end

  def options
    { units: 'metric', APPID: OPEN_WEATHER_API_KEY }
  end
end
