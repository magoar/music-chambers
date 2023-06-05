Rails.application.routes.draw do
  get 'groups/create'
  get 'groups/destroy'
  get 'groups/update'
  get 'musicians/create'
  get 'musicians/destroy'
  get 'musicians/update'
  get 'rooms/create'
  get 'rooms/destroy'
  get 'rooms/update'
  get 'festivals/index'
  get 'festivals/new'
  get 'festivals/create'
  get 'festivals/destroy'
  get 'festivals/show'
  get 'festivals/update'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :festivals do
    resources :rooms, only: [:create, :update, :destroy]
    resources :musicians, only: [:create, :update, :destroy]
    resources :groups, only: [:create, :update, :destroy]
  end
end
