Rails.application.routes.draw do
  root to: 'articles#index'

  resources :articles do
    resources :comments
  end

  resources :tags

  resources :authors

  resources :author_sessions, only: [ :new, :create, :destroy ]

  get 'login' => 'author_sessions#new'
  post 'login' => 'author_sessions#create'
  get 'logout' => 'author_sessions#destroy'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
