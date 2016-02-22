module SimpleForm::Bootstrap::Inputs
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :DateTimeInput
    autoload :TokenInput
  end
end
