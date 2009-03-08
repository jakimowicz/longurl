class CacheMock
  
  attr_accessor :keys_stored, :keys_asked, :storage
  
  def initialize(params = {})
    @storage = {}
    @keys_stored = []
    @keys_asked = []
  end
  
  def [](key)
    @keys_asked << key
    @storage[key]
  end
  
  def []=(key, value)
    @keys_stored << key
    @storage[key] = value
  end
end