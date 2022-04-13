Rails.application.routes.draw do
  #                 USERS ROUTES

  get 'users/index'
  devise_for :users, controllers: {  sessions: 'users/sessions'  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  resources :users, :only =>[:show]
  get 'users/:id', to: 'users#show', as: 'show_user'
 
  # Friends routes

  match '/users',   to: 'users#index',   via: 'get'
  post 'users/send_friend_request/:id', to: 'users#send_friend_request', as: 'send_friend_request'
  delete 'users/remove_friend_request/:id', to: 'users#remove_friend_request', as: 'remove_friend_request'
  delete 'users/remove_friend/:id', to: 'users#remove_friend', as: 'remove_friend'
  post 'users/block_friend/:id', to: 'users#block_friend', as: 'block_friend'
  delete 'users/un_block_friend/:id', to: 'users#un_block_friend', as: 'un_block_friend'
  post 'users/accept_friend_request/:id', to: 'users#accept_friend_request', as: 'accept_friend_request'
  post '/friends/:profile_id', to: 'users#friends', as: 'friends'
  post '/groups/:profile_id', to: 'users#groups', as: 'user_groups'
  

  # Events routes

  resources :events do  
    post 'going', to: 'events#save_going', as: 'going'
    post 'interested', to: 'events#save_interested', as: 'interested'
    delete 'delete_invitation', to: 'events#delete_invitation', as: 'delete_invitation'
    delete 'delete_response', to: 'events#delete_response', as: 'delete_response'
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


  #                    GROUPS ROUTES
  

  get 'groups', to: 'groups#index' ,as: 'groups'
  post 'groups/index', to: 'groups#create',as: 'groups_create'
  get 'groups/new', to: 'groups#new'
  post 'groups/join_group/:id', to: 'groups#join_group' , as: 'join_group'
  delete 'groups/remove_user_from_group/:id', to: 'groups#remove_user_from_group' , as: 'remove_user_from_group'
  delete 'groups/delete/:id', to: 'groups#delete' , as: 'delete'

  # Notifications

  get 'notifications/:user_id', to: 'notifications#index', as:'show_notifications'

  # Not found
  get 'not_found', to: 'pages#not_found', as:'not_found'

  root to: "home#index", as: "home"

  # will cause storage photos not to render
  #get "*path", to: redirect('not_found')

end
