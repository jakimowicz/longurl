module LongURL
  
  # == URL Expander class.
  # Will use Service and Direct classes to expand an url.
  # Each call to external services is cached to save time and cache object is customizable.
  # You can for example use MemCache for the cache. it will allow different instances of Expander and Service to share the same cache.
  # === Examples
  #   # Simple usage
  #   e = LongURL::Expander.new
  #   e.expand("http://tinyurl.com/1c2")                              # => "http://www.google.com"
  #   e.expand("http://tinyurl.com/blnhsg")                           # => "http://www.google.com/search?q=number+of+horns+on+a+unicorn&ie=UTF-8"
  #   e.expand("http://is.gd/iUKg")                                   # => "http://fabien.jakimowicz.com"
  #
  #   # not expandable urls
  #   e.expand("http://www.linuxfr.org")                              # => "http://www.linuxfr.org"
  #
  #   # not expandable urls, calling longurl.org only
  #   e.expand_with_service_only("http://www.linuxfr.org")            # => "http://www.linuxfr.org/pub"
  #
  #   # not expandable urls, direct resolution only
  #   e.direct_resolution("http://www.linuxfr.org")                   # => "http://www.linuxfr.org/pub"
  #
  #   # MemCache as cache
  #   e = LongURL::Expander.new(:cache => MemCache.new("localhost:11211", :namespace => "LongURL"))
  #   e.expand("http://is.gd/iUKg")                                   # => "http://fabien.jakimowicz.com"
  # === Exceptions
  # * LongURL::InvalidURL : will occurs if given url is nil, empty or invalid
  # * LongURL::NetworkError : a network (timeout, host could be reached, ...) error occurs
  # * LongURL::UnknownError : an unknown error occurs
  class Expander
    # Initialize a new Expander.
    # === Options
    # * <tt>:cache</tt>: define a cache which Expander can use. It must implements [] and []= methods.
    def initialize(options = {})
      @@cache = options[:cache] || Hash.new
      @@service = Service.new(:cache => @@cache)
    end
    
    # Expand given url using LongURL::Service class first and then try a direct_resolution.
    def expand(url)
      @@service.query_supported_service_only url
    rescue UnsupportedService
      direct_resolution url
    end
    
    # Try to directly resolve url using LongURL::Direct to get final redirection.
    # This call is cached.
    def direct_resolution(url)
      @@cache[url] ||= Direct.follow_redirections(url)
    end
    
    # Expand given url using LongURL::Service only. If given url is not a expandable url, it will still be given to Service.
    def expand_with_service_only(url)
      @@service.query url
    end
  end
end