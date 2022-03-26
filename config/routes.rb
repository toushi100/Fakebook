Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, controllers: {  sessions: 'users/sessions'  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  match '/users',   to: 'users#index',   via: 'get'
  match '/users',   to: 'users#send_friend_request',   via: 'get'
  resources :users, :only =>[:show]


  root to: "home#index"
end
