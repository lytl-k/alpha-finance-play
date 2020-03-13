module StocksHelper
  def apply_filters(stock_filters)
    stock_filters[:function] = params[:function] if params[:function]
    stock_filters[:symbol] = params[:symbol] if params[:symbol]
    stock_filters[:interval] = params[:interval] if params[:interval]
    stock_filters
  end

  def mangle_stock(response, function)
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

  def mangle_volume(response, function)
    return [] if response['Error Message']

    start_date = Time.parse(params[:start_date]) unless params[:start_date].blank?
    end_date = Time.parse(params[:end_date]) unless params[:end_date].blank?

    volumes = { name: 'Volume', data: {} }

    response[function_keys[function]].each do |key, value|
      if start_date && end_date
        if (start_date..end_date) === Time.parse(key)
          volumes[:data][key] = value['5. volume'] if value['5. volume']
          volumes[:data][key] = value['6. volume'] if value['6. volume']
        end
      else
        volumes[:data][key] = value['5. volume'] if value['5. volume']
        volumes[:data][key] = value['6. volume'] if value['6. volume']
      end
    end

    [volumes]
  end

  def mangle_any_single(response, function, name, value_key)
    return [] if response['Error Message']

    start_date = Time.parse(params[:start_date]) unless params[:start_date].blank?
    end_date = Time.parse(params[:end_date]) unless params[:end_date].blank?

    single = { name: name, data: {} }

    response[function_keys[function]].each do |key, value|
      if start_date && end_date
        if (start_date..end_date) === Time.parse(key)
          single[:data][key] = value[value_key]
        end
      else
        single[:data][key] = value[value_key]
      end
    end

    [single]
  end

  def default_filters
    {
      function: 'TIME_SERIES_MONTHLY_ADJUSTED',
      symbol: 'MSFT',
      interval: '60min'
    }
  end

  def functions
    [
      ['Intra Daily', 'TIME_SERIES_INTRADAY'],
      ['Daily', 'TIME_SERIES_DAILY'],
      ['Daily Adjusted', 'TIME_SERIES_DAILY_ADJUSTED'],
      ['Weekly', 'TIME_SERIES_WEEKLY'],
      ['Weekly Adjusted', 'TIME_SERIES_WEEKLY_ADJUSTED'],
      ['Monthly', 'TIME_SERIES_MONTHLY'],
      ['Monthly Adjusted', 'TIME_SERIES_MONTHLY_ADJUSTED']
    ]
  end

  def intervals
    [
      ['60 Minutes', '60min'],
      ['30 Minutes', '30min'],
      ['15 Minutes', '15min'],
      ['5 Minutes', '5min'],
      ['1 Minute', '1min']
    ]
  end

  def function_keys
    {
      'TIME_SERIES_INTRADAY' => "Time Series (#{params[:interval] || '60min'})",
      'TIME_SERIES_DAILY' => 'Daily Time Series',
      'TIME_SERIES_DAILY_ADJUSTED' => 'Daily Adjusted Time Series',
      'TIME_SERIES_WEEKLY' => 'Weekly Time Series',
      'TIME_SERIES_WEEKLY_ADJUSTED' => 'Weekly Adjusted Time Series',
      'TIME_SERIES_MONTHLY' => 'Monthly Time Series',
      'TIME_SERIES_MONTHLY_ADJUSTED' => 'Monthly Adjusted Time Series'
    }
  end
end
