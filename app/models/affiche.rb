# frozen_string_literal: true

class Affiche < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
