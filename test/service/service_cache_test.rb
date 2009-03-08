$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "cache_mock"
require "constants"
require "longurl/exceptions"
require "longurl/service"

class TestServiceCache < Test::Unit::TestCase
  
  def setup
    @cache = CacheMock.new
    @service = LongURL::Service.new(:cache => @cache)
  end
  
  def test_query_should_use_cache_before_external_fetch
    url = ShortToLong[:is_gd].keys.first
    @service.query_supported_service_only(url)
    assert_equal ['supported_services', url], @cache.keys_asked
    @service.query_supported_service_only(url)
    assert_equal ['supported_services', url, url], @cache.keys_asked
  end
  
  def test_query_should_cache_results_from_supported_services
    ShortToLong.each_value do |service|
      service.each do |short, long|
        @service.query_supported_service_only(short)
        assert @cache.keys_stored.include?(short)
        assert_equal long, @cache[short]
      end
    end
  end
end