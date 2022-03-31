Rails.application.routes.draw do
  get 'comments/index'

  resources :posts do
    resources :comments
  end

  resources :reacts, only: [:create, :destroy]

  delete 'posts/:id/comment/:id', to: 'comments#destroy_comment', as: 'destroy_comment'
  put 'posts/:id/comments/:id', to: 'comments#update_comment', as: 'update_comment'

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
