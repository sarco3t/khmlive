# frozen_string_literal: true

module Ckeditor
  class Picture < Asset
    include Rails.application.routes.url_helpers

    has_one_attached :data

    def url_content
      rails_blob_url(blob)
    end

    def url_thumb
      rails_representation_url(data.variant(resize: '118x100'))
    end

    class << self
      def default_url_options
        Rails.application.config.action_mailer.default_url_options
      end
    end
  end
end
``
