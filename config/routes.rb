Rails.application.routes.draw do
  root to: "listings#index"
  devise_for :users
  resources :listings, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  get '/browse', to: "listings#browse"
  get '/:username', to: "profiles#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
