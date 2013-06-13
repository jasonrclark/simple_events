# encoding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__),'..','..','minitest_helper'))

class NotifierTest < MiniTest::Unit::TestCase

  def setup
    @events = SimpleEvents::Notifier.new
    @events.logger = MiniTest::Mock.new
    @events.logger.expect(:debug, nil, [String])

    @called = false
    @called_with = nil

    @check_method = Proc.new do |*args|
      @called = true
      @called_with = args
    end
  end

  def teardown
    @events.logger = nil
  end

  #
  # Tests
  #

  def test_notifies
    @events.subscribe(:before_call, &@check_method)
    @events.notify(:before_call, :env => "env")

    assert_was_called
    assert_equal([{:env => "env"}], @called_with)
  end

  def test_failure_during_notify_doesnt_block_other_hooks
    @events.subscribe(:after_call) { raise "Boo!" }
    @events.subscribe(:after_call, &@check_method)

    @events.notify(:after_call)

    assert_was_called
  end

  def test_runaway_events
    logger = MiniTest::Mock.new
    logger.expect(:debug, nil, [String])
    SimpleEvents::Notifier.logger = logger

    @events.runaway_threshold = 0
    @events.subscribe(:my_event) {}

    logger.verify
  ensure
    SimpleEvents::Notifier.logger = nil
  end

  def test_clear
    @events.subscribe(:after_call, &@check_method)
    @events.clear
    @events.notify(:after_call)

    assert_was_not_called
  end

  #
  # Helpers
  #

  def assert_was_called
    assert @called, "Event wasn't called"
  end

  def assert_was_not_called
    assert !@called, "Event was called"
  end

end
