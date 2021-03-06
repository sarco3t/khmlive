# frozen_string_literal: true

class Affiche < AbstractPost
  extend FriendlyId
  include Storext.model(extra: {})

  friendly_id :title, use: :slugged
  store_attributes :extra do
    price Integer, default: 0
    date Integer # in unixtime
    user_enabled Boolean, default: false
  end
end
