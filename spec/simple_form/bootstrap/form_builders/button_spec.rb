require 'rails_helper'

RSpec.describe 'button', type: :view do
  class Button
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    def persisted?
      true
    end

    def test
    end
  end

  let(:button_text) { 'Button!' }
  let(:button_options) { {} }
  subject! do
    object = Button.new
    simple_form_for object, url: 'test' do |f|
      f.button :button, button_text, button_options
    end
    render text: output_buffer
  end

  it 'displays the button' do
    expect(rendered).to have_tag('button', text: button_text)
  end

  it 'includes the btn class' do
    expect(rendered).to have_tag('button.btn', text: button_text)
  end

  context 'when no button class is specified' do
    it 'includes the btn-default class' do
      expect(rendered).to have_tag('button.btn.btn-default', text: button_text)
    end
  end

  context 'when a button type is specified' do
    let(:button_class) { ['btn-primary'] }
    let(:button_options) { { class: button_class } }
    it 'does not include the default button type' do
      expect(rendered).not_to have_tag('button.btn.btn-default', text: button_text)
    end

    it 'includes the specified button type' do
      expect(rendered).to have_tag('button.btn.btn-primary', text: button_text)
    end
  end
end
