# frozen_string_literal: true

require_relative 'service'
require 'terminal-table'

# Prints the data to console using terminal-table
# If the data is as follows
# [
#   ['/page1', 7],
#   ['/page2', 5]
# ]
# When called the PrintService with headings as ['Page', 'Visit'], it outputs as follows
# +--------+--------+
# | Pages  | Visits |
# +--------+--------+
# | /page1 | 7      |
# | /page2 | 5      |
# +----------+------+
class PrintService < Service
  def initialize(data:, headings: [])
    @headings = headings
    @data = data
  end

  def call
    raise(StandardError, 'valid data is not present in the file.') if @data.nil? || @data.empty?

    puts Terminal::Table.new headings: @headings, rows: @data
  end
end
