Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }
  root to: 'homes#top'
  get "home/about" =>"homes#about",as:"about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments,  only: [:create, :destroy]
  end

end
