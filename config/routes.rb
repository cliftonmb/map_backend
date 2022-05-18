Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/activities" => "activities#index"
  get "/activities/:id" => "activities#show"
  post "/activities" => "activities#create"

  get "/mapbox_token" => "mapbox_token#index"

  get "/markers" => "markers#index"
  get "/markers/:id" => "markers#show"
  post "/markers" => "markers#create"

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"
  
  get "/favorites" => "favorites#index"
  post "/favorites" => "favorites#create"
  delete "/favorites/:id" => "favorites#destroy"

  get "/genres" => "genres#index"

end
