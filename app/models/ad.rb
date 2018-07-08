# frozen_string_literal: true

class Ad < AbstractPost
  extend FriendlyId
  include Storext.model(extra: {})

  friendly_id :title, use: :slugged
  store_attributes :extra do
    price Integer, default: 0
    city String
    phone String
  end
end
