require 'rails_helper'

RSpec.describe 'token', type: :view do
  class Token
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    def self.reflect_on_association(_)
      OpenStruct.new(macro: :has_many, name: :tokens)
    end

    def token_ids
    end

    def token_ids=(_)
    end

    def persisted?
      true
    end
  end

  let(:token_collection) { [OpenStruct.new(text: 'Text', value: 3)] }
  subject! do
    object = Token.new
    simple_form_for object, url: 'test' do |f|
      f.association :tokens, as: :token, collection: token_collection,
                             label_method: :text, value_method: :value
    end
    render html: output_buffer
  end

  it 'displays the select' do
    expect(rendered).to have_tag('select')
    token_collection.each do |token|
      expect(rendered).to have_tag('option', text: token[:text], value: token[:value])
    end
  end
end
