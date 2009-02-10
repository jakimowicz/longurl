# tc_service.rb
#
#   Created by Vincent Foley on 2005-06-01

$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "longurl/exceptions"
require "longurl/service"

class TestService < Test::Unit::TestCase
  
  ShortToLong = {:tiny_url => {
                  "http://tinyurl.com/cnuw9a" => "http://fabien.jakimowicz.com",
                  "http://tinyurl.com/blnhsg" => "http://www.google.com/search?q=number+of+horns+on+a+unicorn&ie=UTF-8"
                              },
                 :is_gd => {
                   "http://is.gd/iUKg" => "http://fabien.jakimowicz.com",
                   "http://is.gd/iYCo" => "http://www.google.com/search?q=number+of+horns+on+a+unicorn&ie=UTF-8"
                 }
                }

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

  def test_query_should_returns_expanded_url_for_tiny_url
    ShortToLong[:tiny_url].each {|short, long| assert_equal long, @service.query(short)}
  end

  def test_query_should_returns_expanded_url_for_is_gd
    ShortToLong[:is_gd].each {|short, long| assert_equal long, @service.query(short)}
  end
end