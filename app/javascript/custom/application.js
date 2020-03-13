window.toggleInterval = function(thing, check) {
  if ($(thing)[0].value === check) {
    $('#interval-drop').removeClass('d-none');
  } else {
    $('#interval-drop').addClass('d-none');
  }
}
