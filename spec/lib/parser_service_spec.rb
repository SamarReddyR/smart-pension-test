# frozen_string_literal: true

require 'spec_helper'
require 'parser_service'

RSpec.describe ParserService do
  describe '#call' do
    subject { described_class.call(path) }

    context 'with valid path' do
      let(:path) { './spec/fixtures/valid.log' }
      let(:valid_log_results) do
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

      it 'responds to call' do
        expect(described_class).to respond_to(:call)
      end

      it 'return results' do
        expect(subject).to eq(valid_log_results)
      end
    end

    context 'with invalid path' do
      let(:path) { './spec/fixtures/unknown_file.log' }

      it 'raise file missing error' do
        file_missing_error = "Cannot find the file named #{path}, please provide valid file."
        expect { subject }.to raise_error(ArgumentError, file_missing_error)
      end
    end

    context 'with invalid file type' do
      let(:path) { './spec/fixtures/invalid_type.txt' }

      it 'raises unparsable type error' do
        expect { subject }.to raise_error(ArgumentError, described_class::TYPE_ERROR)
      end
    end

    context 'with invalid page path' do
      let(:path) { './spec/fixtures/invalid_page_path.log' }

      it 'warns invalid pages' do
        expect { subject }.to output("Invalid path /page_!r at line number: 3\n").to_stderr
      end
    end

    context 'with invalid ip address' do
      let(:path) { './spec/fixtures/invalid_ip.log' }

      it 'warns invalid IPs' do
        expect { subject }.to output("Invalid IP 280.121.111.010 at line number: 3\n").to_stderr
      end
    end
  end
end
