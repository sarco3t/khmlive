Rails.application.routes.draw do
  namespace :frontend do
    get 'conversations/index'
    get 'conversations/create'
  end
  namespace :frontend do
    get 'comments/index'
    get 'comments/create'
  end
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "frontend/pages#home"

  scope module: 'frontend' do
    resources :users, only: :show, path: 'u' do
    end
    resources :comments, only: :show do
      member do
        post :like
        delete :dislike
      end
    end
    concern :commentable do
      resources :comments, only: %i[index create]
    end
    resources :conversations
    resources :categories, path: '/' do
      resources :posts, path: '/', concerns: :commentable do
        member do
          post :like
          delete :dislike
        end
      end
    end
  end
end
