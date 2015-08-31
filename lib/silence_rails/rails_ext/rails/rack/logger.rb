require 'rails/rack/logger'

# Removes "bookend" logging around requests.
module Rails
  module Rack
    class Logger
      def call_app(*args)
        @app.call(args.last)
      ensure
        ActiveSupport::LogSubscriber.flush_all!
      end
    end
  end
end
