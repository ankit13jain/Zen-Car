Rails.application.routes.draw do
  resources :orders
  devise_for :customers
  resources :customers, :cars

  root 'customers#index'
  get 'order_checkout' => 'orders#checkout'
  get 'order_return' => 'orders#return'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
