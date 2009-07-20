require "longurl/exceptions"
require "longurl/service"
require "longurl/direct"

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
  #   e.expand("http://www.linuxfr.org", :direct_resolution => true)  # => "http://www.linuxfr.org/pub"
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
    # * <tt>:cache</tt>: define a cache which Expander can use.
    #   It must implements [] and []= methods. It can be disabled using false.
    def initialize(options = {})
      # OPTIMIZE : This code is a complete duplicate of cache handling in service.
      if options[:cache].nil?
        @@cache = Hash.new
      elsif options[:cache] == false
        @@cache = nil
      else
        @@cache = options[:cache]
      end
      @@service = Service.new(:cache => @@cache)
    end
    
    # Expand given url using LongURL::Service class first and then try a direct_resolution,
    # unless :direct_resolution is set to false in options hash.
    def expand(url, options = {})
      @@service.query_supported_service_only url
    rescue UnsupportedService
      options[:direct_resolution] == false ? raise(UnsupportedService) : direct_resolution(url)
    end
    
    # Try to directly resolve url using LongURL::Direct to get final redirection.
    # This call is cached.
    def direct_resolution(url)
      # OPTIMIZE : this code is almost identical as the one in service for handling service retrieval.
      if @@cache
        @@cache[url] ||= Direct.follow_redirections(url)
      else
        Direct.follow_redirections(url)
      end
    end
    
    # Expand all url in the given string, if an error occurs while expanding url, then the original url is used.
    # <tt>options</tt> accepts same options as expand, see expand for more details.
    def expand_each_in(text, options = {})
      text.gsub(ShortURLMatchRegexp) do |shorturl| 
        begin
          expand shorturl, options
        rescue  InvalidURL,
                NetworkError,
                TooManyRedirections,
                UnknownError,
                UnsupportedService,
                JSON::ParserError
          shorturl
        end
      end
    end # expand_each_in
    
  end # Expander
end # LongURL