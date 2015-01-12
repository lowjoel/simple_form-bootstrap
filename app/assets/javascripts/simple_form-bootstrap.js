//= require simple_form-bootstrap/date_time_input

(function($) {
  'use strict';
  function initializeComponents(node) {
    // Enable our date/time pickers
    var datePickers = $('input.bootstrap-datepicker', node);
    datePickers.datetimepicker();
  }

  $(document).on('ready', function(e) {
    initializeComponents(document);
  })
  $(document).on('DOMNodeInserted', function(e) {
    initializeComponents(e.target);
  });
  $(document).on('nested:fieldAdded', function(e) {
    initializeComponents(e.field);
  });
})(jQuery);
