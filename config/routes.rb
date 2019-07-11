Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  resources :users
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/auth/github/callback' => 'sessions#create'

  resources :categories do
    resources :recipes, only: [:index, :show]
  end

  resources :comments
  resources :categories
  resources :ingredients

  resources :recipes do
    resources :comments, only: [:new, :create, :index]
    resources :categories, only: [:new, :create, :index]
    resources :ingredients, only: [:new, :create]
  end

  resources :ratings, only: [:new, :create]
  
end
