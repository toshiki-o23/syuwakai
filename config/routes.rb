Rails.application.routes.draw do
  root 'events#index'
  get '/about' => 'homes#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :users do
    get :bookmarks
    get :following, :follower
    get :evaluation
  end
  
  resources :evaluations, only: [:create]
  
  get '/mypage' => 'users#mypage'

  resources :events do
    resource :bookmarks, only: [:create, :destroy]
    resources :user_events, only: [:index, :create, :show] 
    resources :comments, only: [:create]
  end

  resources :relationships, only: [:create, :destroy]
  
  resources :notifications, only: [:index]

  resources :messages, only: [:create]
  resources :rooms, only: [:index, :create, :show]

  resources :dm_messages, only: [:create]
  resources :dm_rooms, only: [:create, :show]


end

