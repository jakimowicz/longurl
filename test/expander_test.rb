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
end