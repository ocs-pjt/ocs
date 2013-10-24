Ocs::Application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {registrations: "registrations"}, token_authentication_key: 'authentication_key'

  post 'permutations/collect', to: 'permutations#collect'
  
  resources :users

  resources :collectors do
    collection do 
      get 'collectors', to: 'collectors#index'
    end
  end

  get 'auth_tokens/create_or_get', to: 'auth_tokens#create_or_get'

end