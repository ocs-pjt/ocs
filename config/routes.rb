Ocs::Application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {registrations: "registrations"}

  post 'permutations/collect', to: 'permutations#collect'
  
  resources :users
end