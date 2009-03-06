$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "uri"
require "longurl/exceptions"
require "longurl/url"

class TestURL < Test::Unit::TestCase
  
  BadURLs = ["http:",
             "http://",
             "http://hoth.entp..."]
  
  NotHTTPURLs = ["bleh",
                 "bleh://",
                 "bleh://asfd.com",
                 "ftp://asdf.com",
                 "google.com",
                 "asdf@toto.com"]
                 
  GoodURL = "http://www.google.com"

  def test_check_should_raise_invalid_url_if_url_is_nil
    assert_raise(LongURL::InvalidURL) { LongURL::URL.check nil }
  end
  
  def test_check_should_raise_invalid_url_if_url_is_empty
    assert_raise(LongURL::InvalidURL) { LongURL::URL.check "" }
  end
  
  def test_check_should_raise_invalid_url_if_url_is_invalid
    BadURLs.each {|bad_url| assert_raise(LongURL::InvalidURL) { LongURL::URL.check bad_url } }
  end
  
  def test_check_should_raise_invalid_url_if_url_is_not_http
    NotHTTPURLs.each {|bad_url| assert_raise(LongURL::InvalidURL) { LongURL::URL.check bad_url } }
  end
  
  def test_check_should_returns_parsed_url_on_success
    assert_equal URI.parse(GoodURL), LongURL::URL.check(GoodURL)
  end
end