class TechnicalIndicatorsController < ApplicationController
  include AlphaApiHelper
  include TechnicalIndicatorsHelper

  def index
    prep_instance_vars!

    @stocks ||= Equity.all

    stock_filters = apply_filters(default_filters)

    @stock = call(stock_filters)
    if @stock['Note']&.include?('frequency') || @stock.empty?
      @stock = []
      ((flash[:notice] ||= []) << 'Please wait another minute before polling the service again.').uniq!
    else
      @stock = mangle_response(@stock)
    end
  end

  helper_method :check_function_vars
end


