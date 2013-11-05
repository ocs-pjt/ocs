Ocs::Application.routes.draw do
  resources :use_cases

  resources :tags

  resources :programs

  root to: "home#index"
  devise_for :users, controllers: {registrations: "registrations"}

  post 'permutations/collect', to: 'permutations#collect'
  get 'permutations/collect', to: 'permutations#collect'

  
  resources :users

  resources :collectors do
    collection do 
      get 'collectors', to: 'collectors#index'
    end
  end

  get 'auth_tokens/create_or_get', to: 'auth_tokens#create_or_get'

end