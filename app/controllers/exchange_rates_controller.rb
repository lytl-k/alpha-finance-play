class ExchangeRatesController < ApplicationController
  include AlphaApiHelper
  include ExchangeRatesHelper

  def index
    @selected_from_currency = params[:from_currency] || default_filters[:from_currency]
    @selected_to_currency = params[:to_currency] || default_filters[:to_currency]

    @markets ||= [Market.all, Crypto.all].flatten

    market_filters = apply_filters default_filters

    p @market = call(market_filters)
    if @market['Note']&.include?('frequency')
      @market = {}
      (flash[:notice] << 'Please wait another minute before polling the service again.').uniq!
    end
  end

  def apply_filters(market_filters)
    market_filters[:from_currency] = params[:from_currency] if params[:from_currency]
    market_filters[:to_currency] = params[:to_currency] if params[:to_currency]
    market_filters
  end

  def default_filters
    {
      function: 'CURRENCY_EXCHANGE_RATE',
      from_currency: 'USD',
      to_currency: 'ZAR'
    }
  end
end
