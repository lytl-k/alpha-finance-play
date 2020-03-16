module TechnicalIndicatorsHelper
  def apply_filters(defaults)
    defaults[:function] = params[:function] if params[:function]
    defaults[:symbol] = params[:symbol] if params[:symbol]
    defaults[:interval] = params[:interval] if params[:interval]
    defaults[:time_period] = params[:time_period] if params[:time_period]
    defaults[:series_type] = params[:series_type] if params[:series_type]
    defaults[:matype] = params[:matype] if params[:matype]
    defaults[:slowkmatype] = params[:slowkmatype] if params[:slowkmatype]
    defaults[:slowdmatype] = params[:slowdmatype] if params[:slowdmatype]
    defaults[:fastdmatype] = params[:fastdmatype] if params[:fastdmatype]
    defaults[:time_period] = params[:time_period] if params[:time_period]
    defaults[:fastperiod] = params[:fastperiod] if params[:fastperiod]
    defaults[:slowperiod] = params[:slowperiod] if params[:slowperiod]
    defaults[:signalperiod] = params[:signalperiod] if params[:signalperiod]
    defaults[:fastkperiod] = params[:fastkperiod] if params[:fastkperiod]
    defaults[:slowkperiod] = params[:slowkperiod] if params[:slowkperiod]
    defaults[:slowdperiod] = params[:slowdperiod] if params[:slowdperiod]
    defaults[:fastdperiod] = params[:fastdperiod] if params[:fastdperiod]
    defaults[:timeperiod1] = params[:timeperiod1] if params[:timeperiod1]
    defaults[:timeperiod2] = params[:timeperiod2] if params[:timeperiod2]
    defaults[:timeperiod3] = params[:timeperiod3] if params[:timeperiod3]
    defaults[:nbdevup] = params[:nbdevup] if params[:nbdevup]
    defaults[:nbdevdn] = params[:nbdevdn] if params[:nbdevdn]


    defaults.slice(*function_info[@selected_function])
  end

  def mangle_response(response)
    return [] if response['Error Message']

    start_date = Time.parse(params[:start_date]) unless params[:start_date].blank?
    end_date = Time.parse(params[:end_date]) unless params[:end_date].blank?

    thing_keys = response["Technical Analysis: #{@selected_function}"].first.last.keys
    thing_array = thing_keys.inject([]) do |memo, key|
      memo << { name: key.tr('_', ' '), data: {} }
    end

    response["Technical Analysis: #{@selected_function}"].each do |key, value|
      if start_date && end_date
        if (start_date..end_date) === Time.parse(key)
          thing_keys.each_with_index do |key2, index|
            thing_array[index][:data][key] = value[key2]
          end
        end
      else
        thing_keys.each_with_index do |key2, index|
          thing_array[index][:data][key] = value[key2]
        end
      end
    end

    thing_array
  end

  def default_filters
    {
      function: 'SMA',
      symbol: 'MSFT',
      interval: 'monthly',
      time_period: 60,
      series_type: 'open',
      fastlimit: 0.01,
      slowlimit: 0.01,
      fastperiod: 12,
      slowperiod: 26,
      signalperiod: 9,
      fastkperiod: 5,
      slowkperiod: 3,
      slowdperiod: 3,
      slowkmatype: 0,
      slowdmatype: 0,
      fastdperiod: 3,
      fastdmatype: 0,
      matype: 0,
      timeperiod1: 7,
      timeperiod2: 14,
      timeperiod3: 28,
      nbdevup: 2,
      nbdevdn: 2,
      acceleration: 0.01,
      maximum: 0.20
    }
  end

  def functions
    TechnicalIndicator.all.map { |ti| [ti.name, ti.symbol] }
  end

  def intervals
    [
      ['Monthly', 'monthly'],
      ['Weekly', 'weekly'],
      ['Daily', 'daily'],
      ['60 Minutes', '60min'],
      ['30 Minutes', '30min'],
      ['15 Minutes', '15min'],
      ['5 Minutes', '5min'],
      ['1 Minute', '1min']
    ]
  end

  def check_function_vars(function)
    function_info[@selected_function.to_s].include? function.to_sym
  end

  def function_info
    {
      'SMA' => %i[function symbol interval time_period series_type],
      'EMA' => %i[function symbol interval time_period series_type],
      'WMA' => %i[function symbol interval time_period series_type],
      'DEMA' => %i[function symbol interval time_period series_type],
      'TEMA' => %i[function symbol interval time_period series_type],
      'TRIMA' => %i[function symbol interval time_period series_type],
      'KAMA' => %i[function symbol interval time_period series_type],
      'MAMA' => %i[function symbol interval series_type fastlimit slowlimit],
      'VWAP' => %i[function symbol interval],
      'T3' => %i[function symbol interval time_period series_type],
      'MACD' => %i[function symbol interval series_type fastperiod slowperiod signalperiod],
      'STOCH' => %i[function symbol interval fastkperiod slowkperiod slowdperiod slowkmatype slowdmatype],
      'STOCHF' => %i[function symbol interval fastkperiod fastdperiod fastdmatype],
      'RSI' => %i[function symbol interval time_period series_type],
      'STOCHRSI' => %i[function symbol interval time_period series_type fastkperiod fastdperiod fastdmatype],
      'WILLR' => %i[function symbol interval time_period],
      'ADX' => %i[function symbol interval time_period],
      'ADXR' => %i[function symbol interval time_period],
      'APO' => %i[function symbol interval series_type fastperiod slowperiod matype],
      'PPO' => %i[function symbol interval series_type fastperiod slowperiod matype],
      'MOM' => %i[function symbol interval time_period series_type],
      'BOP' => %i[function symbol interval],
      'CCI' => %i[function symbol interval time_period],
      'CMO' => %i[function symbol interval time_period series_type],
      'ROC' => %i[function symbol interval time_period series_type],
      'ROCR' => %i[function symbol interval time_period series_type],
      'AROON' => %i[function symbol interval time_period],
      'AROONOSC' => %i[function symbol interval time_period],
      'MFI' => %i[function symbol interval time_period],
      'TRIX' => %i[function symbol interval time_period series_type],
      'ULTOSC' => %i[function symbol interval timeperiod1 timeperiod2 timeperiod3],
      'DX' => %i[function symbol interval time_period],
      'MINUS_DI' => %i[function symbol interval time_period],
      'PLUS_DI' => %i[function symbol interval time_period],
      'MINUS_DM' => %i[function symbol interval time_period],
      'PLUS_DM' => %i[function symbol interval time_period],
      'BBANDS' => %i[function symbol interval time_period series_type nbdevup nbdevdn matype],
      'MIDPOINT' => %i[function symbol interval time_period series_type],
      'MIDPRICE' => %i[function symbol interval time_period],
      'SAR' => %i[function symbol interval acceleration maximum],
      'TRANGE' => %i[function symbol interval],
      'ATR' => %i[function symbol interval time_period],
      'NATR' => %i[function symbol interval time_period],
      'AD' => %i[function symbol interval],
      'ADOSC' => %i[function symbol interval fastperiod slowperiod],
      'OBV' => %i[function symbol interval],
      'HT_TRENDLINE' => %i[function symbol interval series_type],
      'HT_SINE' => %i[function symbol interval series_type],
      'HT_TRENDMODE' => %i[function symbol interval series_type],
      'HT_DCPERIOD' => %i[function symbol interval series_type],
      'HT_DCPHASE' => %i[function symbol interval series_type],
      'HT_PHASOR' => %i[function symbol interval series_type]
    }

  end

  def moving_averages
    [
      ['Simple Moving Average (SMA)', 0],
      ['Exponential Moving Average (EMA)', 1],
      ['Weighted Moving Average (WMA)', 2],
      ['Double Exponential Moving Average (DEMA)', 3],
      ['Triple Exponential Moving Average (TEMA)', 4],
      ['Triangular Moving Average (TRIMA)', 5],
      ['T3 Moving Average', 6],
      ['Kaufman Adaptive Moving Average (KAMA)', 7],
      ['MESA Adaptive Moving Average (MAMA)', 8]
    ]
  end

  def series_types
    [
      ['Open', 'open'],
      ['Closed', 'closed'],
      ['High', 'high'],
      ['Low', 'low']
    ]
  end

  def prep_instance_vars!
    @selected_function = params[:function] || default_filters[:function]
    @selected_symbol = params[:symbol] || default_filters[:symbol]
    @selected_interval = params[:interval] || default_filters[:interval]
    @selected_time_period = params[:time_period] || default_filters[:time_period]
    @selected_series_type = params[:series_type] || default_filters[:series_type]
    @selected_matype = params[:matype] || default_filters[:matype]
    @selected_slowkmatype = params[:slowkmatype] || default_filters[:slowkmatype]
    @selected_slowdmatype = params[:slowdmatype] || default_filters[:slowdmatype]
    @selected_fastdmatype = params[:fastdmatype] || default_filters[:fastdmatype]
    @selected_time_period = params[:time_period] || default_filters[:time_period]
    @selected_fastperiod = params[:fastperiod] || default_filters[:fastperiod]
    @selected_slowperiod = params[:slowperiod] || default_filters[:slowperiod]
    @selected_signalperiod = params[:signalperiod] || default_filters[:signalperiod]
    @selected_fastkperiod = params[:fastkperiod] || default_filters[:fastkperiod]
    @selected_slowkperiod = params[:slowkperiod] || default_filters[:slowkperiod]
    @selected_slowdperiod = params[:slowdperiod] || default_filters[:slowdperiod]
    @selected_fastdperiod = params[:fastdperiod] || default_filters[:fastdperiod]
    @selected_timeperiod1 = params[:timeperiod1] || default_filters[:timeperiod1]
    @selected_timeperiod2 = params[:timeperiod2] || default_filters[:timeperiod2]
    @selected_timeperiod3 = params[:timeperiod3] || default_filters[:timeperiod3]
    @selected_nbdevup = params[:nbdevup] || default_filters[:nbdevup]
    @selected_nbdevdn = params[:nbdevdn] || default_filters[:nbdevdn]

    @functions ||= functions
    @intervals ||= intervals
    @moving_averages ||= moving_averages
    @function_info ||= function_info
    @series_types ||= series_types
  end
end
