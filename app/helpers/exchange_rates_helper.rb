module ExchangeRatesHelper
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
