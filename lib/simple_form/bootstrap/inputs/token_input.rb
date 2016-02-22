# frozen_string_literal: true
class SimpleForm::Bootstrap::Inputs::TokenInput < SimpleForm::Inputs::CollectionSelectInput
  private

  def html_options_for(namespace, css_classes)
    result = super
    result.reverse_merge!(multiple: !!options[:multiple])
    result
  end
end
