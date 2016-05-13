Rails.application.routes.draw do

  get 'products/index'

  get 'products/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:index, :show]
  get :dashboard, to: 'dashboard#index'

  root to: 'home#index'
end
