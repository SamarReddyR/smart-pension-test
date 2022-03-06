# frozen_string_literal: true

require 'spec_helper'
require 'formatter'

RSpec.describe Formatter do
  describe '#format' do
    let(:results) do
      {
        '/contact' => {
          '180.121.111.010' => 2,
          '180.122.111.010' => 1
        },
        '/help_page/1' => {
          '121.118.011.018' => 4
        }
      }
    end

    it 'responds to format' do
      expect(described_class).to respond_to(:format)
    end

    context 'with invalid data' do
      let(:invalid_results) do
        {
          '/contact' => {
            '180.121.111.010' => 'invalid',
            '180.122.111.010' => 1
          },
          '/help_page/1' => {
            '121.118.011.018' => 4
          }
        }
      end
      let(:subject) { described_class.format(results: invalid_results) }

      it 'raises an error' do
        expect { subject }.to raise_error(StandardError, 'File content is in illegal format')
      end
    end

    context 'with valid data and unique as false' do
      let(:subject) { described_class.format(results: results) }

      it 'return all visits' do
        expect(subject).to eq(
          [
            ['/help_page/1', 4],
            ['/contact', 3]
          ]
        )
      end
    end

    context 'with valid data and unique as true' do
      let(:subject) { described_class.format(results: results, unique: true) }

      it 'return unique visits' do
        expect(subject).to eq(
          [
            ['/contact', 2],
            ['/help_page/1', 1]
          ]
        )
      end
    end

    context 'with valid data and order as :asc' do
      subject { described_class.format(results: results, order: :asc) }

      it 'returns all visits in ascending order' do
        expect(subject).to eq(
          [
            ['/contact', 3],
            ['/help_page/1', 4]
          ]
        )
      end
    end
  end
end
