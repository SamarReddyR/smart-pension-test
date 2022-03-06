# frozen_string_literal: true

# An abstract service which creates objects for all the services
class Service
  # Instantiate the object of called service and pass positional arguments,
  # keyword arguments and block
  def self.call(*args, **kwargs, &block)
    new(*args, **kwargs, &block).call
  end
end
