Rails.application.routes.draw do

  concern :paginable do
    get '(page/:page)', action: :index, on: :collection
  end

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :orders, only: [:index, :show]
  resources :products, only: [:index, :show], concerns: :paginable
  get :dashboard, to: 'dashboard#index'

  root to: 'home#index'
end
