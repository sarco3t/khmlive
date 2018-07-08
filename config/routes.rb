Rails.application.routes.draw do
  namespace :frontend do
    get 'comments/index'
    get 'comments/create'
  end
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "frontend/pages#home"

  scope module: 'frontend' do
    concern :commentable do
      resources :comments, only: %i[index create]
    end

    resources :categories, path: '/' do
      resources :posts, path: '/', concerns: :commentable
    end
  end
end
