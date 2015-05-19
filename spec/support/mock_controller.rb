# Adapted from SimpleForm's mock controller
class MockController
  attr_writer :action_name

  def _routes
    self
  end

  def action_name
    defined?(@action_name) ? @action_name : "edit"
  end

  def named_routes
    self
  end
  def route_defined?(selector)
    false
  end
  def mounted_helpers
    self
  end
  def method_defined?(selector)
    false
  end
end

module MockControllerAdditions
  def self.included(module_)
    module_.setup :set_controller
  end

  def set_controller
    @controller = MockController.new
  end
end

RSpec.configure do |config|
  config.include MockControllerAdditions, type: :view
end
