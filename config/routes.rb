Rails.application.routes.draw do
  post 'authentication/login'
  post 'authentication/signup'
  
  resources :wallets
  resources :addresses
  resources :carts
  resources :dishes
  resources :restaurants
  resources 'users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
