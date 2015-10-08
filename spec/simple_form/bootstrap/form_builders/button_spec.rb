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

  let(:button_type) { :button }
  let(:button_text) { 'Button!' }
  let(:button_options) { {} }
  let(:button_block) { nil }
  subject! do
    object = Button.new
    simple_form_for object, url: 'test' do |f|
      f.button button_type, button_text, button_options, &button_block
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

  context 'when a button size is specified' do
    let(:button_class) { ['btn-lg'] }
    let(:button_options) { { class: button_class } }
    it 'includes the btn-default class' do
      expect(rendered).to have_tag('button.btn.btn-default.btn-lg', text: button_text)
    end
  end

  context 'when creating a submit button' do
    let(:button_type) { :submit }
    context 'when no button class is specified' do
      let(:button_class) { ['btn-primary'] }
      let(:button_options) { { class: button_class } }
      it 'includes the btn-primary class' do
        expect(rendered).to have_tag('input.btn.btn-primary', with: { value: button_text })
      end
    end

    context 'when a block is given' do
      let(:proc_text) { 'I am in the proc!' }
      let(:button_block) do
        proc do
          proc_text
        end
      end

      it 'renders the block' do
        expect(rendered).to have_tag('button', text: proc_text)
      end
    end
  end
end
