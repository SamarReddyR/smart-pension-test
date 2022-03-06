# frozen_string_literal: true

# Format the results into following format
# [
#   ['/page1', 5],
#   ['/page2', 7]...
# ]
class Formatter
  
  # Format results based on unique and order params.
  # If unique is true, then add all the IPs for pages as keys, which results
  # unique_visits.
  # If unique is false, then add all the values for each IP for each page,
  # which results all visits.
  def self.format(results:, unique: false, order: :desc)
    begin
      results = if unique
                  results.map { |page, visits| [page, visits.keys.length] }
                else
                  results.map { |page, visits| [page, visits.values.inject(:+)] }
                end
    rescue StandardError
      raise(StandardError, 'File content is in illegal format')
    end

    sort(results: results, order: order)
  end

  class << self
    private

    # Sort results based on the order provided
    def sort(results:, order:)
      results.sort_by do |pair|
        order == :desc ? -pair[1] : pair[1]
      end
    end
  end
end
