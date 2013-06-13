# encoding: utf-8

require 'logger'

module SimpleEvents
  class Notifier

    attr_accessor :runaway_threshold

    def initialize
      @events = {}
      @runaway_threshold = 100
    end

    def subscribe(event, &handler)
      @events[event] ||= []
      @events[event] << handler
      check_for_runaway_subscriptions(event)
    end

    def check_for_runaway_subscriptions(event)
      count = @events[event].size
      logger.debug("Run-away event subscription on #{event}? Subscribed #{count}") if count > @runaway_threshold
    end

    def clear
      @events.clear
    end

    def notify(event, *args)
      return unless @events.has_key?(event)

      @events[event].each do |handler|
        begin
          handler.call(*args)
        rescue => err
          logger.debug("Failure during notify for #{@event}\n#{err.class} #{err.message}")
        end
      end
    end

    @@logger = nil

    def self.logger
      @@logger ||= ::Logger.new($stdout)
    end

    def self.logger=(new_logger)
      @@logger = new_logger
    end

    def logger
      self.class.logger
    end

    def logger=(new_logger)
      self.class.logger = new_logger
    end

  end
end

