module MockViewAdditions
  def simple_form_for(*args, &proc)
    concat super(*args, &proc)
  end
end

RSpec.configure do |config|
  config.include SimpleForm::ActionViewExtensions::FormHelper, type: :view
  config.include MockViewAdditions, type: :view
end
