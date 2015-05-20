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
