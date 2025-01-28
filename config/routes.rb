Rails.application.routes.draw do
  resources :invites do
    member do
      patch :deactivate
    end
  end

  resources :companies

  devise_for :admins

  resources :admins, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
end
