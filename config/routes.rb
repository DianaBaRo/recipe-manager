Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  resources :users, only: [:new, :create, :show]
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :categories do
    resources :recipes, only: [:index, :show]
  end

  resources :comments

  resources :recipes do
    resources :comments, only: [:new, :index]
  end

  resources :ratings, only: [:new, :create]
  
end
