Rails.application.routes.draw do
  get 'chats/show'
  devise_for :users, controllers:{
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }
  root to: 'homes#top'
  get "home/about" =>"homes#about",as:"about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :followings, :followers
    end
  resource :relationships, only: [:create, :destroy]
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments,  only: [:create, :destroy]
  end
  get 'chat/:id' => 'chats#show',as: 'chat'
  resources :chats, only: [:create]
end
