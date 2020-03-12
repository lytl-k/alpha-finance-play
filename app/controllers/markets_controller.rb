class MarketsController < ApplicationController
  include AlphaApiHelper
  include MarketsHelper

  def index
    @selected_function = params[:function] || default_filters[:function]
    @selected_from_symbol = params[:from_symbol] || default_filters[:from_symbol]
    @selected_to_symbol = params[:to_symbol] || default_filters[:to_symbol]
    @selected_interval = params[:interval] || default_filters[:interval]

    @functions = functions
    @intervals = intervals

    @markets ||= Market.all

    market_filters = apply_filters default_filters

    @market = call(market_filters)
    if @market['Note']&.include?('frequency')
      @market = []
      (flash[:notice] << 'Please wait another minute before polling the service again.').uniq!
    else
      @market = mangle_response(@market, params[:function] || 'FX_MONTHLY', @selected_from_symbol)
    end
  end
end
