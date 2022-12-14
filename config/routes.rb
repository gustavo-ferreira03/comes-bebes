Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'signup', to: 'authentication#signup'
  post 'deliveryman/apply', to: 'deliveryman_applications#create'

  resource :user, except: [:index, :create] do
    resource :wallet, only: [:show, :update]
    resources :addresses
    resource :cart, except: [:index, :create] do
      resources :cart_items, except: [:create]
    end
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

  resources :restaurants, only: [:index, :show] do
    resources :dishes do
      match 'add_to_cart', to: 'cart_items#create', via: [:post]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
