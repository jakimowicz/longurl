$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "cache_mock"
require "constants"
require "longurl/exceptions"
require "longurl/service"

class TestSupportedServices < Test::Unit::TestCase
  
  def setup
    @cache = CacheMock.new
  end
  
  def test_service_should_check_if_available_services_are_in_cache
    assert_equal [], @cache.keys_asked
    @service = LongURL::Service.new(:cache => @cache)
    assert_equal ['supported_services'], @cache.keys_asked
  end

  def test_service_should_store_available_services_in_cache
    assert_equal [], @cache.keys_stored
    @service = LongURL::Service.new(:cache => @cache)
    assert_equal ['supported_services'], @cache.keys_stored
  end
  
  def test_supported_services_stored_in_cache_should_be_a_flat_array_of_strings
    @service = LongURL::Service.new(:cache => @cache)
    assert_kind_of Array, @cache['supported_services']
    assert @cache['supported_services'].all? {|object| object.is_a?(String)}
  end
  
  def test_service_should_use_supported_services_stored_in_cache_if_available
    @cache['supported_services'] = ['bleh.com', 'bli.com']
    @service = LongURL::Service.new(:cache => @cache)
    assert_equal ['supported_services'], @cache.keys_asked
    assert_equal ['supported_services'], @cache.keys_stored
    assert_raise(LongURL::UnsupportedService) { @service.query_supported_service_only(ShortToLong[:is_gd].keys.first) }
  end
end