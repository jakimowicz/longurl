$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "constants"
require "longurl/exceptions"
require "longurl/service"

class TestService < Test::Unit::TestCase
  
  def setup
    @service = LongURL::Service.new
  end
  
  def test_query_should_raise_invalid_url_if_url_is_nil
    assert_raise(LongURL::InvalidURL) { @service.query(nil) }
  end

  def test_query_should_raise_invalid_url_if_url_is_empty
    assert_raise(LongURL::InvalidURL) { @service.query('') }
  end

  def test_query_should_returns_given_url_if_not_shorten_url
    assert_equal "http://www.google.com", @service.query("http://www.google.com")
  end
  
  def test_query_should_returns_expanded_url_for_supported_services
    ShortToLong.each_value {|service| service.each {|short, long| assert_equal long, @service.query(short)}}
  end
end