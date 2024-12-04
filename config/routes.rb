Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "profile", to: "pages#profile"
  resources :nannies do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:destroy, :edit, :update]
  get "bookings/:id/accept", to: "bookings#accept", as: :accept_booking
  get "bookings/:id/decline", to: "bookings#decline", as: :decline_booking

  # Defines the root path route ("/")
  # root "posts#index"
end
