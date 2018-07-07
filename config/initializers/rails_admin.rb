# frozen_string_literal: true

require 'i18n'
I18n.available_locales = %i[en uk]
I18n.default_locale = :en

RailsAdmin.config do |config|
  config.excluded_models = ['ActiveStorage::Blob', 'ActiveStorage::Attachment', 'Ckeditor::Picture', 'Ckeditor::Asset', 'AbstractPost']
  config.parent_controller = '::ApplicationController'

  ### Popular gems integration

  config.authorize_with do |_controller|
    unless current_user.try(:admin?)
      flash[:error] = 'You are not an admin'
      redirect_to root_path
    end
  end

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Pundit ==
  config.authorize_with :pundit

  # == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    nestable
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Article' do
    list do
      include_all_fields
      field :category
      exclude_fields :type
    end
    edit do
      field :body, :ck_editor
      field :images, :active_storage_many
      include_all_fields
      exclude_fields :type
    end
  end

  config.model 'Category' do
    nestable_tree({
      max_depth: 3
    })
    edit do
      field :parent_id, :enum do
        enum_method do
          :parent_enum
        end
      end
      field :logo, :active_storage
      include_all_fields
      exclude_fields :ancestry
    end
  end
end
