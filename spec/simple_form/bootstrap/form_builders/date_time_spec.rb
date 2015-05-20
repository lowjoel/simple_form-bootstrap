require 'rails_helper'

RSpec.describe 'date_time', type: :view do
  class DateTimeModel
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    def initialize(column_sql_type)
      @column_sql_type = column_sql_type
    end

    def persisted?
      true
    end

    def column_for_attribute(*)
      Struct.new(:sql_type).new(@column_sql_type)
    end

    def has_attribute?(*)
      true
    end

    def test
      @test ||= DateTime.now
    end
  end

  let(:object) { DateTimeModel.new('datetime') }
  subject! do
    simple_form_for object, url: 'test' do |f|
      f.input :test
    end
    render text: output_buffer
  end

  context 'when the database column is a datetime' do
    it 'displays the text field' do
      expect(rendered).to have_tag('div.form-group.bootstrap_date_time') do
        with_tag('input.bootstrap_date_time', with: { value: object.test })
      end
    end

    it 'has a hidden datepicker control' do
      selector = 'div.form-group.bootstrap_date_time div.input-group'
      required_style = { style: 'display: none' }

      expect(rendered).to have_tag(selector, with: required_style) do
        with_tag('input.bootstrap_date_time', with: { type: 'hidden' })
      end
    end
  end
end
