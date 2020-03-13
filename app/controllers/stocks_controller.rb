class StocksController < ApplicationController
  include AlphaApiHelper
  include StocksHelper

  def index
    @selected_function = params[:function] || default_filters[:function]
    @selected_symbol = params[:symbol] || default_filters[:symbol]
    @selected_interval = params[:interval] || default_filters[:interval]

    @functions = functions
    @intervals = intervals

    @stocks ||= Equity.all

    stock_filters = apply_filters default_filters

    @stock_response = call(stock_filters)
    if @stock_response['Note']&.include?('frequency')
      @stock = []
      (flash[:notice] << 'Please wait another minute before polling the service again.').uniq!
    else
      @stock = mangle_stock(@stock_response, params[:function] || default_filters[:function])
      @volume = mangle_volume(@stock_response, params[:function] || default_filters[:function])
      if %w[TIME_SERIES_WEEKLY_ADJUSTED TIME_SERIES_MONTHLY_ADJUSTED TIME_SERIES_DAULY_ADJUSTED].include? (params[:function] || default_filters[:function])
        @adjusted = mangle_any_single(@stock_response, params[:function] || default_filters[:function], 'Adjusted Close', '5. adjusted close')
      end
      if %w[TIME_SERIES_WEEKLY_ADJUSTED TIME_SERIES_MONTHLY_ADJUSTED TIME_SERIES_DAULY_ADJUSTED].include? (params[:function] || default_filters[:function])
        @dividend = mangle_any_single(@stock_response, params[:function] || default_filters[:function], 'Dividends', '7. dividend amount')
      end
      if %w[TIME_SERIES_DAULY_ADJUSTED].include? (params[:function] || default_filters[:function])
        @coefficient = mangle_any_single(@stock_response, params[:function] || default_filters[:function], 'Split Coefficient', '8. split coefficient')
      end
    end
  end
end
