require 'rails/railtie'

class SimpleForm::Bootstrap::Railtie < Rails::Railtie
  config.eager_load_namespaces << SimpleForm::Bootstrap
end
