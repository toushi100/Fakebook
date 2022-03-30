Rails.application.routes.draw do
  #                 USERS ROUTES


  get 'users/index'
  devise_for :users, controllers: {  sessions: 'users/sessions'  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
 
  match '/users',   to: 'users#index',   via: 'get'
  post 'users/send_friend_request/:id', to: 'users#send_friend_request', as: 'send_friend_request'
  delete 'users/remove_friend_request/:id', to: 'users#remove_friend_request', as: 'remove_friend_request'
  delete 'users/remove_friend/:id', to: 'users#remove_friend', as: 'remove_friend'
  post 'users/block_friend/:id', to: 'users#block_friend', as: 'block_friend'
  delete 'users/un_block_friend/:id', to: 'users#un_block_friend', as: 'un_block_friend'
  post 'users/accept_friend_request/:id', to: 'users#accept_friend_request', as: 'accept_friend_request'
  resources :users, :only =>[:show]


  #                    GROUPS ROUTES

  
  get 'groups/index', to: 'groups#index'
  post 'groups/index', to: 'groups#create'
  get 'groups/new', to: 'groups#new'
  post 'groups/add_user_to_group/:id', to: 'groups#add_user_to_group' , as: 'add_user_to_group'

  root to: "home#index"
end
