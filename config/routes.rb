Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/generate_pdf/:festival_id", to: "schedules#generate_pdf", as: :generate_pdf
  # Defines the root path route ("/")
  # root "articles#index"
  resources :festivals do
    resources :rooms, only: [:index, :create, :update]
    resources :musicians, only: [:index, :create, :update]
    resources :groups, only: [:index, :create, :update]
    resources :schedules, only: [:index, :new, :show]
    resources :timeslots, only: [:index, :create, :update]
  end
  resources :musicians, only: [:destroy]
  resources :rooms, only: [:destroy]
  resources :groups, only: [:destroy]
  resources :timeslots, only: [:destroy]
end
