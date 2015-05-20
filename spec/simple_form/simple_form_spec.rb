require 'rails_helper'

RSpec.describe SimpleForm do
  describe '.setup' do
    it 'yields self' do
     result = nil
      subject.setup do |config|
        result = config
      end

      expect(result).to equal(subject)
    end
  end
end
