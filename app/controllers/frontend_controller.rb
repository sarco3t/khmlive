# frozen_string_literal: true

class FrontendController < ApplicationController
  before_action :set_menu

  def set_menu
    @menus = Menu.includes(:category).active
  end
end
