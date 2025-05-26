Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "movies#index"
  get "movies" => "movies#index", as: :movies
  get "movies/:id" => "movies#show", as: :movie
end
