Rails.application.routes.draw do
  get 'clients/dashboard'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get :dashboard, to: 'clients#dashboard'

  root to: 'application#index'
end
