class ImpressResourceJob < ApplicationJob
  queue_as :default

  def perform(ids, type)
    type.classify.constantize.where(id: ids).each { |model| impressionist(model) }
  end
end
