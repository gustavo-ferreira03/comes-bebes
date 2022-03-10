Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'signup', to: 'authentication#signup'
  post 'deliveryman/apply', to: 'deliveryman_applications#create'

  get 'profile', to: 'users#show'
  resource :user, except: [:index, :create, :show] do
    resource :wallet
    resources :carts
    resources :addresses
  end
  
  namespace :admin do
    resources :users
    resources :deliveryman_applications, except: [:create, :destroy]
  end

  namespace :restaurant_owner do
    resource :restaurant, except: [:index] do
      resource :address, only: [:show, :update]
      match 'logo', to: 'images#show_logo', via: [:get]
      match 'logo', to: 'images#update_logo', via: [:patch, :put]
      resources :dishes do
        resources :images
      end
    end
  end

  resources :dishes
  resources :restaurants

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
