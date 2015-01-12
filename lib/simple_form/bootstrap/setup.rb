# Handles configuration Simple Form with Bootstrap defaults.
module SimpleForm::Bootstrap::Setup
  def setup
    yield self
    configure_simple_form
  end

  private

  def configure_simple_form
  end
end
