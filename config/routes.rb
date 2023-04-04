Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'shortened_urls#index'
  
  resources :shortened_urls

  get "/:short_url", to: "shortened_urls#show"

  resource :session, only: [:new, :create, :destroy]
end
