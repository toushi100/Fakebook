Rails.application.routes.draw do

  get 'users/index'
  devise_for :users, controllers: {  sessions: 'users/sessions'  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  get "comments/index"
  resources :posts do
    resources :comments
  end
  # Post Reactions routes
  #Like
  post "posts/:id/likes", to: "likes#create", as: "add_likes"
  delete "posts/:id/likes/:id", to: "likes#destroy", as: "remove_likes"
  #Angry
  post "posts/:id/angry", to: "angries#create", as: "add_angry"
  delete "posts/:id/angry/:id", to: "angries#destroy", as: "remove_angry"
  #Heart
  resources :hearts, only: [:create, :destroy]
  post "posts/:id/hearts", to: "hearts#create", as: "add_hearts"
  delete "posts/:id/hearts/:id", to: "hearts#destroy", as: "remove_hearts"
  #Sad
  post "posts/:id/sads", to: "sads#create", as: "add_sads"
  delete "posts/:id/sads/:id", to: "sads#destroy", as: "remove_sads"
  #Wow
  post "posts/:id/wows", to: "wows#create", as: "add_wows"
  delete "posts/:id/wows/:id", to: "wows#destroy", as: "remove_wows"
  # Comment Delete and Update Routes
  delete "posts/:id/comment/:id", to: "comments#destroy_comment", as: "destroy_comment"
  put "posts/:id/comments/:id", to: "comments#update_comment", as: "update_comment"
  get "users/index"
  match '/users',   to: 'users#index',   via: 'get'
  post 'users/send_friend_request/:id', to: 'users#send_friend_request', as: 'send_friend_request'
  delete 'users/remove_friend_request/:id', to: 'users#remove_friend_request', as: 'remove_friend_request'
  delete 'users/remove_friend/:id', to: 'users#remove_friend', as: 'remove_friend'
  post 'users/block_friend/:id', to: 'users#block_friend', as: 'block_friend'
  delete 'users/un_block_friend/:id', to: 'users#un_block_friend', as: 'un_block_friend'
  post 'users/accept_friend_request/:id', to: 'users#accept_friend_request', as: 'accept_friend_request'
  resources :users, :only =>[:show]
  root to: "home#index"
end
