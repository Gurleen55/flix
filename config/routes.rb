Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "movies#index"
  get "movies" => "movies#index", as: :movies
  get "movies/:id" => "movies#show", as: :movie
  get "movies/:id/edit" => "movies#edit", as: :edit_movie
  patch "movies/:id" => "movies#update"
end
