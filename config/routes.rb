Rails.application.routes.draw do
  # namespace :item do
  #   get 'list_steps/show'
  #   get 'list_steps/update'
  # end
  # namespace :item do
  #   get 'list_steps_controller/show'
  #   get 'list_steps_controller/update'
  # end
  root 'pages#index'
  devise_for :users,
              path: '',
              path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' }
  resources :users, only: [:show]
  resources :items do
    resources :list_steps, only: [:show, :update], controller: 'item/list_steps'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "home#index"
end
