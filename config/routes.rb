Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, controllers: {  sessions: 'users/sessions'  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  match '/users',   to: 'users#index',   via: 'get'
  post 'users/send_friend_request/:id', to: 'users#send_friend_request', as: 'send_friend_request'
  
  post 'users/accept_friend_request/:id', to: 'users#accept_friend_request', as: 'accept_friend_request'
  resources :users, :only =>[:show]


  root to: "home#index"
end
