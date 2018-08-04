# frozen_string_literal: true

module ApplicationHelper
  def mark_as_viewed(model)
    view = model.views.find_or_initialize_by(
      ip_address: request.ip,
    )
    view.assign_attributes(
      user_id: @current_user&.id,
      controller_name: controller_name,
      action_name: action_name,
      params: request.params,
      referrer: request.referrer
    )
    view.save unless view.persisted?
  end
end
