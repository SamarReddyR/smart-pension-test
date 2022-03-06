# frozen_string_literal: true

require './application'

RSpec.describe Application do
  describe '#run!' do
    subject { described_class.run!(path) }

    it 'responds to call' do
      expect(described_class).to respond_to(:run!)
    end
  end
end
