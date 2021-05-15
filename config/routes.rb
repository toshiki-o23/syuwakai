Rails.application.routes.draw do

  root 'events#index'
  # get 'users/show'
  # get 'bookmarks/create'
  # get 'bookmarks/destroy'
  devise_for :users

  resources :users

  get '/mypage' => 'users#mypage'

  resources :events do
    resource :bookmarks, only: [:create, :destroy]
  end
end
