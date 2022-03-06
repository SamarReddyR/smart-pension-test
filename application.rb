# frozen_string_literal: true

require_relative 'lib/print_service'
require_relative 'lib/parser_service'
require_relative 'lib/formatter'

# Starting point of the ruby app
class Application
  def self.run!(path)
    # pass the path to ParserService and get the results
    results = ParserService.call(path)

    # pass the results to Formatter (order is :desc by default) and get all_visits and unique visits.
    all_visits = Formatter.format(results: results)
    unique_visits = Formatter.format(results: results, unique: true)

    # pass all_visits and unique_visits to PrintService to print the results in the console
    PrintService.call(data: all_visits, headings: %w[Page Visits])
    PrintService.call(data: unique_visits, headings: ['Page', 'Unique Visits'])
  end
end

# Get the path of file from command line.
path = ARGV[0]

# Run the application only from terminal.
Application.run!(path) if __FILE__ == $PROGRAM_NAME
