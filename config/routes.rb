Rails.application.routes.draw do
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
  post "posts/:id/hearts", to: "hearts#create", as: "add_heart"
  delete "posts/:id/hearts/:id", to: "hearts#destroy", as: "remove_heart"
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
  devise_for :users, controllers: {
                       sessions: "users/sessions",
                     }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  match "/users", to: "users#index", via: "get"
  resources :users, :only => [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
