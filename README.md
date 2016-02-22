simple_form-bootstrap
===
[![Build Status](https://travis-ci.org/lowjoel/simple_form-bootstrap.svg?branch=master)](https://travis-ci.org/lowjoel/simple_form-bootstrap) [![Coverage Status](https://coveralls.io/repos/lowjoel/simple_form-bootstrap/badge.svg)](https://coveralls.io/r/lowjoel/simple_form-bootstrap) [![Code Climate](https://codeclimate.com/github/lowjoel/simple_form-bootstrap/badges/gpa.svg)](https://codeclimate.com/github/lowjoel/simple_form-bootstrap)

Integrating Bootstrap-looking form controls with Simple Form.

## Installation

 1. Add to your application's Gemfile: `gem 'simple_form-bootstrap'`. The following types of
    input controls are supported, so long they are properly installed in your application. Ensure
    that the control is included in your `application.js` _before_ the Simple Form-Bootstrap
    JavaScript.

    1. If you want to use Date/Time pickers, install the `bootstrap3-datetimepicker-rails` gem.
    2. If you want to use the nicely styled Bootstrap Select picker, install the
       `bootstrap-select-rails` gem.
    3. If you want to use the Token picker, you need to
       a. Install the `bootstrap_tokenfield_rails` and `twitter-typeahead-rails` gems.
       b. Require `twitter/typeahead` and `bootstrap-tokenfield` in that order in `application.js`.
       c. Require `tokenfield-typeahead` and `bootstrap-tokenfield` in that order in
          `application.css`.
       d. These extra `@extend`s are needed for Typeahead.js 0.11:
          ```scss
          .tt-menu {
            @extend .tt-dropdown-menu;
          }
          .tt-suggestion.tt-selectable:hover {
            @extend .tt-suggestion.tt-cursor;
          }
          ```

 2. Add to your application's javascript: `//= require simple_form-bootstrap`
 3. Empty the Simple Form initializer:
    ```ruby
# config/initializers/simple_form.rb
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
end
    ```

    1. You can still put configuration settings in, but it should no longer be necessary.

 4. Restart your development server.

## Features

 1. It adds the appropriate button styling to all buttons. By default, the `btn` and `btn-default`
    styles are added to all buttons. Submit buttons get `btn-primary` instead of `btn-default`.
 2. It allows `submit` buttons to accept blocks. When a block is specified, the submit button will
    use a \<button> tag instead of an \<input> tag.
