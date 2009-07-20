$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "longurl/expander"

class TextExpander < Test::Unit::TestCase
  def setup
    @expander = LongURL::Expander.new
  end
  
  def test_expand_each_in_should_expand_friendfeed_urls
    assert_equal "Product requirements document - Wikipedia, http://en.wikipedia.org/wiki/Product_requirements_document the free encyclopedia",
      @expander.expand_each_in("Product requirements document - Wikipedia, http://ff.im/-31OFh the free encyclopedia")
  end
  
  def test_expand_each_in_should_not_change_strings_with_no_urls
    assert_equal "i'm not to be changed !!!", @expander.expand_each_in("i'm not to be changed !!!")
  end
  
  def test_expand_each_in_should_be_able_to_expand_multiple_urls
    assert_equal "Those websites are great: http://www.flickr.com/photos/jakimowicz & http://www.google.com/profiles/fabien.jakimowicz",
      @expander.expand_each_in("Those websites are great: http://tinyurl.com/r9cm9p & http://is.gd/Bnxy")
  end
  
  def test_expand_each_in_should_not_replace_unexpandable_urls_if_direct_resolution_is_false
    assert_equal "Those websites are great: http://www.flickr.com/photos/jakimowicz & http://www.google.com/profiles/fabien.jakimowicz",
      @expander.expand_each_in( "Those websites are great: http://www.flickr.com/photos/jakimowicz & http://is.gd/Bnxy",
                                :direct_resolution => false )
  end
  
  def test_expand_should_raise_UnsupportedService_if_service_is_not_supported_and_direct_resolution_disabled
    assert_raise(LongURL::UnsupportedService) do
      @expander.expand("http://www.google.com", :direct_resolution => false)
    end
  end

  def test_expand_should_use_direct_resolution_by_default
    assert_nothing_raised do
      assert_equal "http://fabien.jakimowicz.com", @expander.expand("http://fabien.jakimowicz.com")
    end
  end
  
  def test_expand_should_expand_supported_services
    assert_equal "http://www.flickr.com/photos/jakimowicz", @expander.expand('http://tinyurl.com/r9cm9p')
  end
  
  def test_expand_should_handle_direct_resolution_if_asked
    assert_equal "http://fabien.jakimowicz.com", @expander.expand("http://fabien.jakimowicz.com", :direct_resolution => true)
  end
  
  def test_expand_with_should_continue_to_resolve_urls_even_if_direct_resolution_is_true
    assert_equal "http://www.flickr.com/photos/jakimowicz", @expander.expand('http://tinyurl.com/r9cm9p', :direct_resolution => true)
  end
end