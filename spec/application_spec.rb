# frozen_string_literal: true

require './application'

RSpec.describe Application do
  describe '#run!' do
    subject { described_class.run!(path) }

    context 'with valid file' do
      let(:path) { './spec/fixtures/webserver.log' }
      let(:webserver_log_output) do
        <<~RESULT
          +--------------+--------+
          | Page         | Visits |
          +--------------+--------+
          | /about/2     | 83     |
          | /contact     | 81     |
          | /home        | 72     |
          | /help_page/1 | 71     |
          | /index       | 71     |
          | /about       | 66     |
          +--------------+--------+
          +--------------+---------------+
          | Page         | Unique Visits |
          +--------------+---------------+
          | /help_page/1 | 20            |
          | /contact     | 20            |
          | /home        | 20            |
          | /index       | 20            |
          | /about/2     | 19            |
          | /about       | 18            |
          +--------------+---------------+
        RESULT
      end

      it 'responds to call' do
        expect(described_class).to respond_to(:run!)
      end

      it 'outputs result to stdout' do
        expect { subject }.to output(webserver_log_output).to_stdout
      end
    end

    context 'with invalid page path' do
      let(:path) { './spec/fixtures/invalid_page_path.log' }
      let(:invalid_page_path_log_output) do
        <<~RESULT
          +--------------+--------+
          | Page         | Visits |
          +--------------+--------+
          | /help_page/1 | 1      |
          | /contact     | 1      |
          +--------------+--------+
          +--------------+---------------+
          | Page         | Unique Visits |
          +--------------+---------------+
          | /help_page/1 | 1             |
          | /contact     | 1             |
          +--------------+---------------+
        RESULT
      end

      it 'warns invalid pages' do
        expect { subject }.to output("Invalid path /page_!r at line number: 3\n").to_stderr
      end

      it 'skips invalid page paths and outputs result to stdout' do
        expect { subject }.to output(invalid_page_path_log_output).to_stdout
      end
    end

    context 'with invalid ip address' do
      let(:path) { './spec/fixtures/invalid_ip.log' }
      let(:invalid_ip_log_output) do
        <<~RESULT
          +--------------+--------+
          | Page         | Visits |
          +--------------+--------+
          | /help_page/1 | 1      |
          | /contact     | 1      |
          +--------------+--------+
          +--------------+---------------+
          | Page         | Unique Visits |
          +--------------+---------------+
          | /help_page/1 | 1             |
          | /contact     | 1             |
          +--------------+---------------+
        RESULT
      end

      it 'warns invalid IPs' do
        expect { subject }.to output("Invalid IP 280.121.111.010 at line number: 3\n").to_stderr
      end

      it 'skips invalid IPs and outputs result to stdout' do
        expect { subject }.to output(invalid_ip_log_output).to_stdout
      end
    end
  end
end
