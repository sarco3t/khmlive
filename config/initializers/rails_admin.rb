# frozen_string_literal: true

require 'i18n'
I18n.available_locales = %i[en uk]
I18n.default_locale = :uk

RailsAdmin.config do |config|
  config.label_methods << :category_title
  config.excluded_models = [
    'ActiveStorage::Blob', 'ActiveStorage::Attachment', 'Ckeditor::Picture', 'Ckeditor::Asset', 'AbstractPost',
    "Mailboxer::Conversation",
    "Mailboxer::Conversation::OptOut",
    "Mailboxer::Notification",
    "Mailboxer::Notification::Message",
    "Mailboxer::Receipt",
    "Mailboxer::Message",
    "View",
    "Like",
  ]
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

  config.model 'Affiche' do
    list do
      field :category
      field :body
      field :created_at
      field :updated_at
      exclude_fields :type
    end
    edit do
      field :body, :ck_editor
      field :category
      field :slug
      field :user
      field :images, :active_storage_many
      exclude_fields :type
    end
  end

  config.model 'Ad' do
    list do
      field :category
      field :body
      field :created_at
      field :updated_at
      exclude_fields :type
    end
    edit do
      field :body, :ck_editor
      field :category
      field :slug
      field :user
      field :images, :active_storage_many
      exclude_fields :type
    end
  end

  config.model 'Article' do
    list do
      field :category
      field :body
      field :created_at
      field :updated_at
      exclude_fields :type
    end
    edit do
      field :body, :ck_editor
      field :category
      field :slug
      field :user
      field :images, :active_storage_many
      exclude_fields :type
    end
  end

  config.model 'Post' do
    list do
      field :category
      field :body
      field :created_at
      field :updated_at
      exclude_fields :type
    end
    edit do
      field :body, :ck_editor
      field :category
      field :slug
      field :user
      field :images, :active_storage_many
      exclude_fields :type
    end
  end

  config.model 'Banner' do
    field :image, :active_storage
    include_all_fields
    field :start_date do
      strftime_format do
        '%d-%m-%Y %H:%M:%S'
      end
    end
    field :end_date do
      strftime_format do
        '%d-%m-%Y %H:%M:%S'
      end
    end

    exclude_fields :views
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

  config.model 'Menu' do
    object_label_method do
      :category_or_title
    end
    nestable_list true
    include_all_fields
    exclude_fields :ancestry
  end

end
