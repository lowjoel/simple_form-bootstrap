// Hijacks the default Bootstrap date-time picker to always format dates in the specified format
// through the use of a hidden field.
(function($) {
  'use strict';
  if ($.fn.selectpicker) {
    return;
  }

  $.fn.selectpicker = function() {
    return this;
  };
}(jQuery));
