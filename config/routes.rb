Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  devise_for :users
  root 'events#index'

  resources :events do
    resource :bookmarks, only: [:create, :destroy]
  end
end
