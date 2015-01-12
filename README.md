simple_form-bootstrap
===
Integrating Bootstrap-looking form controls with Simple Form.

## Installation

 1. Add to your application's Gemfile: `gem 'simple_form-bootstrap'`. The following types of
    input controls are supported, so long they are properly installed in your application. Ensure
    that the control is included in your `application.js` _before_ the Simple Form-Bootstrap
    JavaScript.

    a. If you want to use Date/Time pickers, install the `bootstrap3-datetimepicker-rails` gem.
    b. If you want to use the nicely styled Bootstrap Select picker, install the
       `bootstrap-select-rails` gem.

 2. Add to your application's javascript: `//= require simple_form-bootstrap`
 3. Create a new initializer:
    ```ruby
# config/initializers/simple_form_bootstrap.rb
# Use this setup block to configure all options available in SimpleForm.
SimpleForm::Bootstrap.setup do |config|

end
    ```
 4. Restart your development server.
