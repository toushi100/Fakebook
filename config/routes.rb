Rails.application.routes.draw do
  resources :posts
  get 'users/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  match '/users',   to: 'users#index',   via: 'get'
  resources :users, :only =>[:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
