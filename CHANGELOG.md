## master

### enhancements

### bug fixes
  * The proper ID for date/time pickers should be generated for non-JavaScript aware browsers first;
    Browsers with JavaScript would reassign the label to the hidden date/time picker. This fixes
    tests written using Capybara, without JavaScript support.
  * Specifying the button size (e.g. `btn-lg`) should still generate the appropriate button class
  (`btn-default` or `btn-primary`). [@lowjoel](https://github.com/lowjoel)

## 1.1.0

### enhancements
  * There is no longer a need to retain a Simple Form initialiser, as well as a Simple 
  Form-Bootstrap initialiser. Just call `SimpleForm::setup` and the Bootstrap defaults would be 
  automatically applied. [@lowjoel](https://github.com/lowjoel)
  * Started writing specs and running them on Travis!  

### bug fixes
