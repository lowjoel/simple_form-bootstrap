module SimpleForm::Bootstrap
  extend ActiveSupport::Autoload

  autoload :Setup
  extend SimpleForm::Bootstrap::Setup

  eager_autoload do
  end

  # Configuration options
  extend SimpleForm::Bootstrap::Setup
end

require 'simple_form/bootstrap/railtie' if defined?(Rails)
