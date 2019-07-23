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

  resources :recipes do
    resources :comments, only: [:new, :create, :index]
    resources :categories, only: [:new, :create, :index]
    resources :recipe_ingredients, only: [:new, :create, :index]
  end

  resources :recipe_ingredients do
    collection do
      delete 'destroy_multiple'
    end
  end

  resources :ratings, only: [:new, :create]
  
  get 'newest_recipe' => 'recipes#newest_recipe'

  get 'most_popular_user' => 'users#most_popular_user'
end
