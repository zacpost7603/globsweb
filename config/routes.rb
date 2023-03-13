Rails.application.routes.draw do
  get "search" => "search#index"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get "/auth/:provider/callback" => "authentications#create"
  resources :users, except: [:index, :new]
  resources :sessions, except:[:index, :new, :show, :edit, :update, :destroy]
  resources :globs do
      resources :comments
    end 
  resources :password_resets
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    
  # Defines the root path route ("/")
  get "about" => "sites#about"
   root "sites#index"
end
