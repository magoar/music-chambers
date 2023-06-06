Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :festivals do
    resources :rooms, only: [:index, :create, :update, :destroy]
    resources :musicians, only: [:index, :create, :update, :destroy]
    resources :groups, only: [:index, :create, :update, :destroy]
  end
end
