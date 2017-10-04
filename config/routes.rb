Rails.application.routes.draw do
  resources :recommendations
  resources :orders
  devise_for :customers
  resources :customers, except: :create
  resources :cars
  resources :recommendations

  post 'create_customer' => 'customers#create', as: :create_customer

  get 'order_history' => 'orders#history'
  get 'order_availability' => 'orders#availability'
  root 'customers#index'
  get 'order_checkout' => 'orders#checkout'
  get 'order_return' => 'orders#return'
  get 'order_cancel' => 'orders#cancel'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
