Ocs::Application.routes.draw do
  resources :tasks, only: [:index, :destroy]

  resources :use_cases, only: :index do
    collection do
      post  'get_key',            to: 'use_cases#get_key'
      get   'get_key',            to: 'use_cases#get_key'
      post  'get_key_from_form',  to: 'use_cases#get_key_from_form'
      get   'get_key_from_form',  to: 'use_cases#get_key_from_form'
    end
  end

  resources :tags

  resources :programs

  devise_for :users, controllers: {
    registrations:      "registrations", 
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  post  'resources/collect',      to: 'resources#collect'

  resources :permutations, only: :index do
    collection do
      post  'permutations/collect',  to: 'permutations#collect'
      get   'permutations/collect',  to: 'permutations#collect'
    end
  end

  resources :traces, only: :index do
    collection do
      post  'traces/collect',  to: 'traces#collect'
      get   'traces/collect',  to: 'traces#collect'
    end
  end

  resources :regular_expressions, only: :index do
    collection do
      post  'regular_expressions/collect',  to: 'regular_expressions#collect'
      get   'regular_expressions/collect',  to: 'regular_expressions#collect'
    end
  end

  resources :users, except: [:edit, :create, :new] do 
    collection do 
      post 'authentication_key', to: 'users#authentication_key'
    end
  end

  resources :collectors do 
    member do 
      get 'versions', to: 'collectors#versions'
    end
  end

  resources :collector_versions, only: :show

  post  '/search/export'        => 'search#search_export'
  get   '/search/export_form'   => 'search#export_form'

  get   '/statistics/world'     => 'statistics#world'
  get   '/statistics/regions'   => 'statistics#regions'
  post  '/statistics/regions'   => 'statistics#regions'


  root to: "home#index"
end