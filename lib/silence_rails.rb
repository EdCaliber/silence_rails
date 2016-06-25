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
    klasses = [
      ActionController::LogSubscriber,
      ActionMailer::LogSubscriber,
      ActionView::LogSubscriber,
      ActiveRecord::LogSubscriber,
      ActiveJob::Logging::LogSubscriber
    ]

    subscribers = ActiveSupport::LogSubscriber.subscribers
    instances = subscribers.select { |x| klasses.include?(x.class) }
    instances.each { |subscriber| unsubscribe(subscriber) }
  end

  # private

  def unsubscribe(instance)
    instance.patterns.each do |ev|
      ActiveSupport::Notifications.notifier.listeners_for(ev).each do |sub|
        next unless instance == sub.instance_variable_get(:@delegate)
        ActiveSupport::Notifications.unsubscribe(sub)
      end
    end

    ActiveSupport::LogSubscriber.subscribers.delete(instance)
  end
end
