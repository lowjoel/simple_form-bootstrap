(function($) {
  'use strict';
  /* global Bloodhound */

  var oldTokenField = $.fn.tokenfield;
  if (!oldTokenField) {
    $.fn.tokenfield = function() {};
    return;
  }

  /**
   * Gets the selected options matching the given selector from the given select field.
   *
   * The return array of objects use 'value' for the displayed text. This is because Token field
   * uses the value field when editing tokens, so we stick to its convention. The Select option
   * is in optionValue.
   *
   * @param {Object} $select The select field to query.
   * @param {String|null} selector The selector to filter the options by, if any.
   * @returns {Array} The array of values which match the selector.
   */
  function getSelectOptions($select, selector) {
    var $options = $select.find('option');
    if (selector) {
      $options = $options.filter(selector);
    }

    return $options.map(function() {
      var text = this.text;
      return {
        optionValue: this.value || text,
        value: text
      };
    }).get();
  }

  /**
   * Finds the given value in the given select field.
   *
   * @param {Object} $select The select field.
   * @param {String} value The value to search in the select.
   */
  function findOption($select, value) {
    return $select.find('option[value="' + value + '"]');
  }

  /**
   * Handles the pre-selection of a value.
   *
   * This blocks the addition if there is no option by that name.
   *
   * @param {Object} $select The select field.
   * @param e The event triggering the selection.
   * @returns {boolean} Return false to block the change.
   */
  function beforeSelectValue($select, e) {
    var $option = findOption($select, e.attrs.optionValue);
    if ($option.length === 0) {
      return false;
    }
  }

  /**
   * Generates a before-selection event handler for the given select field.
   * @param {HTMLSelectElement} select The select field to change.
   * @returns {Function} The handler for the given select field.
   */
  function generateBeforeSelectValueHandler(select) {
    return function(e) {
      return beforeSelectValue($(select), e);
    };
  }

  /**
   * Handles the selection of a value.
   *
   * @param {Object} $select The select field.
   * @param e The event triggering the selection.
   * @returns {boolean} Return false to block the change.
   */
  function onSelectValue($select, e) {
    var $option = findOption($select, e.attrs.optionValue);
    $option.prop('selected', true);
  }

  /**
   * Generates a on-selected event handler for the given select field.
   * @param {HTMLSelectElement} select The select field to change.
   * @returns {Function} The handler for the given select field.
   */
  function generateOnSelectValueHandler(select) {
    return function(e) {
      return onSelectValue($(select), e);
    };
  }

  /**
   * Handles the removal of a value.
   *
   * @param {Object} $select The select field.
   * @param e The event triggering the selection.
   * @returns {boolean} Return false to block the change.
   */
  function onRemoveValue($select, e) {
    var $option = findOption($select, e.attrs.optionValue);
    if ($option.length !== 0) {
      $option.prop('selected', false);
    }
  }

  /**
   * Generates a value-removed event handler for the given select field.
   * @param {HTMLSelectElement} select The select field to change.
   * @returns {Function} The handler for the given select field.
   */
  function generateOnRemoveValueHandler(select) {
    return function(e) {
      return onRemoveValue($(select), e);
    };
  }

  function initialiseTokenField() {
    var select = this;

    $(select).hide();
    var $text = $('<input type="text" />').insertAfter(select);
    var options = getSelectOptions($(select));

    var bloodhound = new Bloodhound({
      local: options,
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace
    });
    bloodhound.initialize();

    var $result = oldTokenField.call($text, {
      typeahead: [null, { displayKey: 'value', source: bloodhound.ttAdapter() }]
    });

    oldTokenField.call($result, 'setTokens', getSelectOptions($(select), ':selected'));

    $result.on('tokenfield:createtoken', generateBeforeSelectValueHandler(select));
    $result.on('tokenfield:createdtoken', generateOnSelectValueHandler(select));
    $result.on('tokenfield:edittoken', generateBeforeSelectValueHandler(select));
    $result.on('tokenfield:editedtoken', generateOnSelectValueHandler(select));
    $result.on('tokenfield:removedtoken', generateOnRemoveValueHandler(select));

    return $result;
  }

  $.fn.tokenfield = function() {
    if (arguments.length === 0 || typeof arguments[0] === 'object') {
      return this.addClass('tokenfield').removeClass('token').map(function() {
        if ($(this).data('bs.tokenfield')) {
          return this;
        }

        return initialiseTokenField.call(this);
      });
    } else {
      return oldTokenField.apply(this, arguments);
    }
  };

  for (var i in oldTokenField) {
    if (oldTokenField.hasOwnProperty(i)) {
      $.fn.tokenfield[i] = oldTokenField[i];
    }
  }
})(jQuery);
