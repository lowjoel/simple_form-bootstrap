module SimpleForm::Bootstrap
  extend ActiveSupport::Autoload

  autoload :Setup
  extend SimpleForm::Bootstrap::Setup

  eager_autoload do
  end

  # Configuration options
end
