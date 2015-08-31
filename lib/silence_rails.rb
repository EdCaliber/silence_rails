module SilenceRails
  class Railtie < Rails::Railtie
    config.after_initialize do
      SilenceRails.setup
    end
  end

  module_function

  def setup
    require 'silence_rails/rails_ext/rails/rack/logger'
    unsubscribe_default_subscribers
  end

  def unsubscribe_default_subscribers
    ActiveSupport::LogSubscriber.log_subscribers.dup.each do |subscriber|
      case subscriber
      when ActionController::LogSubscriber,
           ActionMailer::LogSubscriber,
           ActionView::LogSubscriber,
           ActiveRecord::LogSubscriber,
           ActiveJob::Logging::LogSubscriber
        unsubscribe(subscriber)
      end
    end
  end

  # private

  def unsubscribe(sub)
    sub.patterns.each { |p| ActiveSupport::Notifications.unsubscribe(p) }
    ActiveSupport::LogSubscriber.log_subscribers.delete(sub)
  end
end
