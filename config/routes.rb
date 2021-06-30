Rails.application.routes.draw do

  resources :rooms, only: %i[index show create]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  root 'events#index'

  resources :users do
    get :bookmarks
    get :following, :follower
  end


  resources :relationships, only: [:create, :destroy]
  get '/mypage' => 'users#mypage'

  resources :events do
    resource :bookmarks, only: [:create, :destroy]
  end
end

