Rails.application.routes.draw do
  namespace :frontend do
    get 'companies/index'
  end
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
    namespace :pages, path: '/' do
      get :privacy
      get :banner
      get :law
      get :contacts
    end

    resources :banners do
      collection do
        get :next
      end
    end
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
    resources :conversations do
      resources :messages
    end
    get :posters, to: "categories#posters"
    get :ads, to: "categories#ads"
    resources :companies do
      get :category
    end
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
