Rails.application.routes.draw do
  root 'dashboard#index'

  get 'cryptos/index', to: 'cryptos#index'
  get 'markets/index', to: 'markets#index'
end
