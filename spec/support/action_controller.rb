RSpec.configure do
  ActionView::RoutingUrlFor.class_eval do
    include ActionDispatch::Routing::UrlFor
  end
end
