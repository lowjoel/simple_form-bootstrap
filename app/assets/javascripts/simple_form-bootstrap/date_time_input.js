// Hijacks the default Bootstrap date-time picker to always format dates in the specified format
// through the use of a hidden field.
(function($) {
  'use strict';
  /* global moment */

  // Machine-readable formats used to store dates in hidden fields
  var DATE_FORMAT = 'YYYY-MM-DD';
  var DATETIME_FORMAT = 'YYYY-MM-DDTHH:mm:ssZZ';
  var DATETIME_FORMAT_RAILS = 'YYYY-MM-DD HH:mm:ss ZZ';

  var oldDateTimePicker = $.fn.datetimepicker;
  if (!oldDateTimePicker) {
    return;
  }

  var methods = {
    initialise: function(arg) {
      // Synchronise the proper display format
      this.each(methods.initialiseFormat);

      // Create the controls
      arg = arg || {};
      oldDateTimePicker.call(
        this.filter(':not(input.bootstrap-timepicker)').parent(),
        $.extend({}, arg, { pickTime: false }));
      oldDateTimePicker.call(
        this.filter('input.bootstrap-timepicker').parent(),
        arg);

      // Hide the backing date picker and show the actual date picker.
      this.attr('type', 'text');
      this.parent().css('display', '');
      this.parent().next('input[type=text]').attr('type', 'hidden');

      return this;
    },

    initialiseFormat: function() {
      var $textField = $(this);
      var displayFormat = $textField.data('dateFormat');

      // Parse date in field (if provided)
      var thisDate = moment($textField.val(), [DATETIME_FORMAT_RAILS, displayFormat]);
      if (thisDate.isValid()) {
        // Set displayed text field
        $textField.val(thisDate.format(displayFormat));

        // Set hidden field
        var hiddenFormat = $textField.hasClass('bootstrap-timepicker') ? DATETIME_FORMAT :
          DATE_FORMAT;
        $textField.parent().next('input').val(thisDate.format(hiddenFormat));
      }
    }
  };

  // Replace the datetimepicker prototypes
  $.fn.datetimepicker = function(arg) {
    return methods.initialise.call(this, arg);
  };
  $.fn.datetimepicker.defaults = oldDateTimePicker.defaults;

  // Ensure that the dates are properly formatted in the text field.
  $(document).on('dp.change dp.show', '.bootstrap-datepicker:' +
  'not(.bootstrap-timepicker)', function (e) {
    var date = e.date;
    var rails_date_format = date.format(DATE_FORMAT);
    $(this).next('input[type=hidden]').val(rails_date_format);
  });

  $(document).on('dp.change dp.show', '.bootstrap-timepicker', function (e) {
    var date = e.date;
    var rails_date_format = date.format(DATETIME_FORMAT);
    $(this).next('input[type=hidden]').val(rails_date_format);
  });
}(jQuery));
