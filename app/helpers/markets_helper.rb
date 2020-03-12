module MarketsHelper
  def apply_filters(market_filters)
    market_filters[:function] = params[:function] if params[:function]
    market_filters[:from_symbol] = params[:from_symbol] if params[:from_symbol]
    market_filters[:to_symbol] = params[:to_symbol] if params[:to_symbol]
    market_filters
  end

  def mangle_response(response, function, market)
    return [] if response['Error Message']

    start_date = Time.parse(params[:start_date]) unless params[:start_date].blank?
    end_date = Time.parse(params[:end_date]) unless params[:end_date].blank?

    opens = { name: 'Open', data: {} }
    highs = { name: 'High', data: {} }
    lows = { name: 'Low', data: {} }
    closed = { name: 'Closed', data: {} }

    response[function_keys[function]].each do |key, value|
      if start_date && end_date
        if (start_date..end_date) === Time.parse(key)
          opens[:data][key] = value['1. open']
          highs[:data][key] = value['2. high']
          lows[:data][key] = value['3. low']
          closed[:data][key] = value['4. close']
        end
      else
        opens[:data][key] = value['1. open']
        highs[:data][key] = value['2. high']
        lows[:data][key] = value['3. low']
        closed[:data][key] = value['4. close']
      end
    end

    [opens, highs, lows, closed]
  end

  def default_filters
    {
      function: 'FX_MONTHLY',
      from_symbol: 'USD',
      to_symbol: 'ZAR'
    }
  end

  def functions
    [
      ['Intra Daily', 'FX_INTRADAY'],
      ['Daily', 'FX_DAILY'],
      ['Weekly', 'FX_WEEKLY'],
      ['Monthly', 'FX_MONTHLY']
    ]
  end

  def function_keys
    {
      'FX_INTRADAY' => 'Time Series FX (Intraday)',
      'FX_DAILY' => 'Time Series FX (Monthly)',
      'FX_WEEKLY' => 'Time Series FX (Weekly)',
      'FX_MONTHLY' => 'Time Series FX (Monthly)'
    }
  end
end
