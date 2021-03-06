class CryptosController < ApplicationController
  include AlphaApiHelper
  include CryptosHelper

  def index
    flash[:notice] = []
    @selected_crypto = params[:symbol] || 'BTC'
    @selected_function = params[:function] || 'DIGITAL_CURRENCY_MONTHLY'
    @selected_market = params[:market] || 'USD'
    @functions = functions

    @cryptos ||= Crypto.all
    @markets ||= Market.all

    rating_filters = apply_rating_filters default_filters.merge(function: 'CRYPTO_RATING')
    crypto_filters = apply_crypto_filters default_filters

    @rating = call(rating_filters)
    if @rating['Note']&.include?('frequency')
      @rating = {}
      (flash[:notice] << 'Please wait another minute before polling the service again.').uniq!
    end

    @crypto = call(crypto_filters)
    if @crypto['Note']&.include?('frequency')
      @crypto = []
      (flash[:notice] << 'Please wait another minute before polling the service again.').uniq!
    else
      @crypto = mangle_response(@crypto, params[:function] || 'DIGITAL_CURRENCY_MONTHLY', @selected_market)
    end
  end
end
