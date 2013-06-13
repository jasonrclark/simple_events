require File.expand_path(File.join(File.dirname(__FILE__),'..','minitest_helper'))

class TestSimpleEvents < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::SimpleEvents::VERSION
  end
end
