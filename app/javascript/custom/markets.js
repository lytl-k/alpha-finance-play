window.toggleInterval = function(thing) {
  if ($(thing)[0].value === 'FX_INTRADAY') {
    $('#interval-drop').removeClass('d-none');
  } else {
    $('#interval-drop').addClass('d-none');
  }
}
