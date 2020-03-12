module CryptosHelper
  def mangle_response(response, function, market)
    return [] if response['Error Message']

    start_date = Time.parse(params[:start_date]) unless params[:start_date].blank?
    end_date = Time.parse(params[:end_date]) unless params[:end_date].blank?

    response[function_keys[function]].inject([]) do |memo, (key, value)|
      if start_date && end_date
        memo << [key, value["1a. open (#{market})"]] if (start_date..end_date) === Time.parse(key)
      else
        memo << [key, value["1a. open (#{market})"]]
      end
      memo
    end
  end

  def default_filters
    {
      function: 'DIGITAL_CURRENCY_MONTHLY',
      symbol: 'BTC',
      market: 'USD'
    }
  end

  def currency_exchange_default_filters
    {
      function: 'CURRENCY_EXCHANGE_RATE',
      from_currency: 'ZAR',
      to_currency: 'USD'
    }
  end

  def functions
    [
      ['Daily', 'DIGITAL_CURRENCY_DAILY'],
      ['Weekly', 'DIGITAL_CURRENCY_WEEKLY'],
      ['Monthly', 'DIGITAL_CURRENCY_MONTHLY']
    ]
  end

  def function_keys
    {
      'DIGITAL_CURRENCY_DAILY' => 'Time Series (Digital Currency Daily)',
      'DIGITAL_CURRENCY_WEEKLY' => 'Time Series (Digital Currency Weekly)',
      'DIGITAL_CURRENCY_MONTHLY' => 'Time Series (Digital Currency Monthly)'
    }
  end
end
