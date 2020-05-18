Rails.application.routes.draw do
  root to: "listings#index"
  devise_for :users
  resources :listings, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :cart, only: [:index, :create, :destroy]
  get '/browse', to: "listings#browse"
  get '/search', to: "listings#search"
  get '/:username', to: "profiles#index"
  get '/payments/session', to: "payments#get_stripe_id"
  get '/payments/success', to: "payments#success"
  post '/payments/webhook', to: "payments#webhook"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
