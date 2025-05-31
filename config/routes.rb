Rails.application.routes.draw do
  resources :reviews
  get "up" => "rails/health#show", as: :rails_health_check

  root "movies#index"
  resources :movies
end
