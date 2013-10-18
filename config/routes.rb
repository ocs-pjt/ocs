Ocs::Application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {registrations: "registrations"}

  post 'permutations/collect', to: 'permutations#collect'
  
  resources :users

  resources :collectors do
    collection do 
      get 'collectors', to: 'collectors#index'
    end
  end
end