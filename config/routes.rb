Rails.application.routes.draw do

  root 'events#index'

  # get 'users/show'
  # get 'bookmarks/create'
  # get 'bookmarks/destroy'
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  resources :users

  resources :relationships, only: [:create, :destroy]
  get '/mypage' => 'users#mypage'

  resources :events do
    resource :bookmarks, only: [:create, :destroy]
  end
end
