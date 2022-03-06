# frozen_string_literal: true

require 'spec_helper'
require 'print_service'

RSpec.describe PrintService do
  describe '#call' do
    subject { described_class.call(headings: headings, data: data) }

    context 'with invalid log output' do
      let(:headings) { [] }
      let(:data) { [] }

      it 'responds to call' do
        expect(described_class).to respond_to(:call)
      end

      it 'outputs error message' do
        expect { subject }.to raise_error(StandardError, 'valid data is not present in the file.')
      end
    end

    context 'with sample log output' do
      let(:headings) { %w[Pages Visits] }
      let(:data) { [['/home', 5], ['/about/1', 8]] }

      it 'prints out results' do
        expect { subject }.to output(
          <<~RESULT
            +----------+--------+
            | Pages    | Visits |
            +----------+--------+
            | /home    | 5      |
            | /about/1 | 8      |
            +----------+--------+
          RESULT
        ).to_stdout
      end
    end

    context 'with out headings' do
      let(:data) { [['/home', 5], ['/about/1', 8]] }

      it 'prints out results with no headings' do
        expect { described_class.call(data: data) }.to output(
          <<~RESULT
            +----------+---+
            | /home    | 5 |
            | /about/1 | 8 |
            +----------+---+
          RESULT
        ).to_stdout
      end
    end
  end
end
