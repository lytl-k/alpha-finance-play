Rails.application.routes.draw do
  root 'dashboard#index'

  get 'cryptos/index',        to: 'cryptos#index'
  get 'markets/index',        to: 'markets#index'
  get 'exchange_rates/index', to: 'exchange_rates#index'
  get 'sectors/index',        to: 'sectors#index'
  get 'stocks/index',         to: 'stocks#index'
end
