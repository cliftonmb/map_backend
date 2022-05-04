Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/activities" => "activities#index"
  post "/activities" => "activities#create"

  get "/mapbox_token" => "mapbox_token#index"

  get "/markers" => "markers#index"
  get "/markers/:id" => "markers#show"
  post "/markers" => "markers#create"
end
