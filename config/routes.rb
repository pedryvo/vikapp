Rails.application.routes.draw do
  resources :invites
  resources :companies
  devise_for :admins

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
end
