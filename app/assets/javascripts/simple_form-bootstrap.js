//= require simple_form-bootstrap/date_time_input

(function($) {
  'use strict';
  function initializeComponents(node) {
    // Enable our date/time pickers
    var datePickers = $('input.bootstrap-datepicker', node);
    datePickers.datetimepicker();

    // Enable our styled Bootstrap select controls, only when using the default select collection.
    var selects = $('select.select.form-control', node);
    selects.selectpicker();
  }

  $(document).on('ready', function(e) {
    initializeComponents(document);
  });
  $(document).on('DOMNodeInserted', function(e) {
    initializeComponents(e.target);
  });
  $(document).on('nested:fieldAdded', function(e) {
    initializeComponents(e.field);
  });
})(jQuery);
