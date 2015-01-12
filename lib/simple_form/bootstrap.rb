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

  # Configuration options
  extend SimpleForm::Bootstrap::Setup

  # Method used to tidy up errors.
  mattr_accessor :error_method
  @@error_method = :first
end

require 'simple_form/bootstrap/railtie' if defined?(Rails)
