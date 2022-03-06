# frozen_string_literal: true

require 'spec_helper'
require 'service'

RSpec.describe Service do
  describe '#call' do
    it 'responds to call' do
      expect(described_class).to respond_to(:call)
    end
  end
end
