window.toggleInterval = function(thing, check) {
  if ($(thing)[0].value === check) {
    $('#interval-drop').removeClass('d-none');
  } else {
    $('#interval-drop').addClass('d-none');
  }
}

window.selectIndicatorStuffs = function(func) {
  functions.forEach(thing => {
    $('#' + thing).addClass('d-none')
    $('#' + `${thing}_label`).addClass('d-none')
  })

  key_value = func.options[func.selectedIndex].value.toLowerCase()
  selected_funcs = function_stuffs[key_value]

  selected_funcs.forEach(func => {
    $('#' + func).removeClass('d-none')
    $('#' + `${func}_label`).removeClass('d-none')
  })
}

var functions = ['symbol', 'interval', 'time_period', 'series_type', 'fastlimit', 'slowlimit', 'fastperiod', 'slowperiod', 'signalperiod', 'fastkperiod', 'slowkperiod', 'slowdperiod', 'slowkmatype', 'slowdmatype', 'fastdperiod', 'fastdmatype', 'matype', 'timeperiod1', 'timeperiod2', 'timeperiod3', 'nbdevup', 'nbdevdn', 'acceleration', 'maximum']
var function_stuffs = {
  sma: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  ema: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  wma: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  dema: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  tema: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  trima: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  kama: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  mama: ['function', 'symbol', 'interval', 'series_type', 'fastlimit', 'slowlimit'],
  vwap: ['function', 'symbol', 'interval'],
  t3: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  macd: ['function', 'symbol', 'interval', 'series_type', 'fastperiod', 'slowperiod', 'signalperiod'],
  stoch: ['function', 'symbol', 'interval', 'fastkperiod', 'slowkperiod', 'slowdperiod', 'slowkmatype', 'slowdmatype'],
  stochf: ['function', 'symbol', 'interval', 'fastkperiod', 'fastdperiod', 'fastdmatype'],
  rsi: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  stochrsi: ['function', 'symbol', 'interval', 'time_period', 'series_type fastkperiod fastdperiod fastdmatype'],
  willr: ['function', 'symbol', 'interval', 'time_period'],
  adx: ['function', 'symbol', 'interval', 'time_period'],
  adxr: ['function', 'symbol', 'interval', 'time_period'],
  apo: ['function', 'symbol', 'interval', 'series_type', 'fastperiod', 'slowperiod', 'matype'],
  ppo: ['function', 'symbol', 'interval', 'series_type', 'fastperiod', 'slowperiod', 'matype'],
  mom: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  bop: ['function', 'symbol', 'interval'],
  cci: ['function', 'symbol', 'interval', 'time_period'],
  cmo: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  roc: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  rocr: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  aroon: ['function', 'symbol', 'interval', 'time_period'],
  aroonosc: ['function', 'symbol', 'interval', 'time_period'],
  mfi: ['function', 'symbol', 'interval', 'time_period'],
  trix: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  ultosc: ['function', 'symbol', 'interval', 'timeperiod1', 'timeperiod2', 'timeperiod3'],
  dx: ['function', 'symbol', 'interval', 'time_period'],
  minus_di: ['function', 'symbol', 'interval', 'time_period'],
  plus_di: ['function', 'symbol', 'interval', 'time_period'],
  minus_dm: ['function', 'symbol', 'interval', 'time_period'],
  plus_dm: ['function', 'symbol', 'interval', 'time_period'],
  bbands: ['function', 'symbol', 'interval', 'time_period', 'series_type nbdevup nbdevdn matype'],
  midpoint: ['function', 'symbol', 'interval', 'time_period', 'series_type'],
  midprice: ['function', 'symbol', 'interval', 'time_period'],
  sar: ['function', 'symbol', 'interval', 'acceleration', 'maximum'],
  trange: ['function', 'symbol', 'interval'],
  atr: ['function', 'symbol', 'interval', 'time_period'],
  natr: ['function', 'symbol', 'interval', 'time_period'],
  ad: ['function', 'symbol', 'interval'],
  adosc: ['function', 'symbol', 'interval', 'fastperiod', 'slowperiod'],
  obv: ['function', 'symbol', 'interval'],
  ht_trendline: ['function', 'symbol', 'interval', 'series_type'],
  ht_sine: ['function', 'symbol', 'interval', 'series_type'],
  ht_trendmode: ['function', 'symbol', 'interval', 'series_type'],
  ht_dcperiod: ['function', 'symbol', 'interval', 'series_type'],
  ht_dcphase: ['function', 'symbol', 'interval', 'series_type'],
  ht_phasor: ['function', 'symbol', 'interval', 'series_type']
}
