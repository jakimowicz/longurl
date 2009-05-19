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
                 "asdf@toto.com",
                 "httpd://asdf.com"]
                 
  GoodURLs = ["http://www.google.com", "https://rubyonrails.org"]

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
    GoodURLs.each {|good_url| assert_equal URI.parse(good_url), LongURL::URL.check(good_url)}
  end
end