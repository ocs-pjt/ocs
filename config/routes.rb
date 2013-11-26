Ocs::Application.routes.draw do
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

  resources :collectors

  get 'auth_tokens/create_or_get', to: 'auth_tokens#create_or_get'

  resources :concurrents

  root to: "home#index"
end