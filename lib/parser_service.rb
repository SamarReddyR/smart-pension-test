# frozen_string_literal: true

require 'English'
require_relative 'service'

# Parse the file and return results in following format
# {
#   "/page1" => {
#     "111.111.111.111" => 2,
#     "222.222.222.222" => 4
#   },
#   "/page2" -> {
#     "111.111.111.111" => 1,
#     "001.001.001.100" => 2
#   }
# }
class ParserService < Service
  VAILD_TYPES = %w[.log].freeze
  TYPE_ERROR = "Please provide a valid file with any of below type\n( #{VAILD_TYPES.join('/')} )".freeze

  def initialize(path)
    @path = path
    @results = {}
    validate_file!
  end

  # Parses the given file into nested hashes format
  def call
    File.foreach(@path) do |line|
      if valid_line?(line)
        page, ip = line.split(' ')
        update_results!(page, ip)
      end
    end

    @results
  end

  private

  # Returns true if the IP address and page_path in the line are valid
  def valid_line?(line)
    page_path, ip_address = line.split(' ')
    valid_ip?(ip_address) && valid_page_path?(page_path)
  end

  # Updates the results in nested hash format
  def update_results!(page, ip)
    if @results.key?(page)
      @results[page][ip] = @results[page].key?(ip) ? @results[page][ip] + 1 : 1
    else
      @results[page] = Hash[ip, 1]
    end
  end

  # Validate given file and raises error if file doesn't exist or if file is
  # not a parse-able type
  def validate_file!
    raise(ArgumentError, TYPE_ERROR) unless parsable_type?

    return if File.exist?(@path)

    file_missing_error = "Cannot find the file named #{@path}, please provide valid file."
    raise(ArgumentError, file_missing_error)
  end

  # Returns true if page path is valid
  def valid_page_path?(page_path)
    path_regexp = %r{^[/a-zA-Z0-9\-._~]+$}
    return true if page_path.match?(path_regexp)

    warn("Invalid path #{page_path} at line number: #{$INPUT_LINE_NUMBER}")
    false
  end

  # Returns true if IP address is valid
  def valid_ip?(ip_address)
    ip_regexp = /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/
    return true if ip_address.match?(ip_regexp)

    warn("Invalid IP #{ip_address} at line number: #{$INPUT_LINE_NUMBER}")
    false
  end

  # Returns true if provided file is a parse-able type file
  def parsable_type?
    VAILD_TYPES.include?(File.extname(@path))
  end
end
