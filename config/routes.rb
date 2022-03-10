Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'signup', to: 'authentication#signup'

  get 'profile', to: 'users#show'
  resource :user, except: [:index, :create, :show] do
    resource :wallet
    resources :carts
    resources :addresses
  end
  
  post 'applications', to: 'deliveryman_applications#create'
  
  namespace :admin do
    resources :users
    resources :deliveryman_applications, except: [:create, :destroy]
  end

  namespace :restaurant_owner do
    resource :restaurant, except: [:index] do
      resources :address, except: [:create, :destroy]
      resources :images, except: [:create, :destroy]
      resources :dishes
    end
  end

  resources :dishes
  resources :restaurants

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
