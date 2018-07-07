Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "frontend/pages#home"

  scope module: 'frontend' do
    resources :categories, path: '/' do
      resources :posts, path: '/'
    end
  end
end
