module SimpleForm::Bootstrap
  extend ActiveSupport::Autoload

  autoload :Setup
  autoload :FormBuilders

  eager_autoload do
    autoload :Inputs
  end

  # Because we are augmenting Simple Form with our input fields, we need to load even when eager
  # loading is not enabled
  SimpleForm::Bootstrap::FormBuilders.load!
end

module SimpleForm
  class << self
    # Extend the normal Simple Form configuration options with ours.
    prepend SimpleForm::Bootstrap::Setup
  end
end

if defined?(Rails)
  require 'simple_form/bootstrap/railtie'
  require 'simple_form/bootstrap/engine'
end
