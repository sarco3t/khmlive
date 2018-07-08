# frozen_string_literal: true

require 'active_storage'

module Ckeditor
  class Asset < ApplicationRecord
    include Ckeditor::Orm::ActiveRecord::AssetBase
    include Ckeditor::ActiveStorage
  end
end
