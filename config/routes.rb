Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'signup', to: 'authentication#signup'

  resources :users
  get 'profile', to: 'users#show'

  post 'applications', to: 'deliveryman_applications#create'
  
  namespace :admin do
    resources :users
    resources :deliveryman_applications, except: :create
  end

  namespace :restaurant_owner do
    resources :restaurants, except: :index
  end

  resources :wallets
  resources :addresses
  resources :carts
  resources :dishes
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
