Ocs::Application.routes.draw do
  resources :tasks, only: [:index, :destroy]

  resources :use_cases, only: :index do
    collection do
      post 'get_key', to: 'use_cases#get_key'
      get 'get_key', to: 'use_cases#get_key'
      post 'get_key_from_form', to: 'use_cases#get_key_from_form'
      get 'get_key_from_form', to: 'use_cases#get_key_from_form'
    end
  end

  resources :tags

  resources :programs

  devise_for :users, controllers: {registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}

  post 'permutations/collect', to: 'permutations#collect'
  get 'permutations/collect', to: 'permutations#collect'

  resources :users

  resources :collectors do 
    member do 
      get 'versions', to: 'collectors#versions'
    end
  end

  resources :collector_versions, only: :show

  post '/search/export' => 'search#search_export'
  get '/search/export_form' => 'search#export_form'

  get '/statistics/world' => 'statistics#world'
  get '/statistics/regions' => 'statistics#regions'
  post '/statistics/regions' => 'statistics#regions'

  root to: "home#index"
end