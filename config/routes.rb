Rails.application.routes.draw do
  get '/' => 'home#index'
  
  resources :users do

    resources :photos
  end

  resources :tags, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  
  get '/log-in' => "sessions#new"
  post '/log-in' => "sessions#create"
  get '/log-out' => "sessions#destroy", as: :log_out
  get '/user/:id/show-users' => "users#index", as: :show_users
  post '/user/:id/follow/:followee' => "follow#create", as: :follow
  delete '/user/:id/follow/:followee' => "follow#destroy", as: :unfollow
end