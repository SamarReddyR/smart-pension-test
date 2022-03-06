# frozen_string_literal: true

# Starting point of the ruby app
class Application
  def self.run!(path)
    # pass the path to ParserService and get the results

    # pass the results to Formatter (order is :desc by default) and get all_visits and unique visits.

    # pass all_visits and unique_visits to PrintService to print the results in the console
  end
end

# Get the path of file from command line.
path = ARGV[0]

# Run the application only from terminal.
Application.run!(path) if __FILE__ == $PROGRAM_NAME
