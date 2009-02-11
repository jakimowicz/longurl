module LongURL
  
  class << self

    # Expand given <tt>:url</tt> to a longest one.
    # First, expand will try to expand url using longurl.org service.
    # Then, it will try to direct follow redirections on the given url and returns final one.
    # === Options
    # * <tt>:try_unsupported</tt> : use longurl.org to resolve the address, even if it is not a supported service
    # * <tt>:direct_resolution</tt> : fetch url and follow redirection to find the final destination
    # * <tt>:cache</tt> : cache object to use, must implement get and set functions. See LongURL::Cache.
    # === Types
    # <tt>url</tt> is expected to be a String and returns a String with the url.
    # === Examples
    #   # simple expands
    #   LongURL.expand("http://tinyurl.com/1c2")                              # => "http://www.google.com"
    #   LongURL.expand("http://tinyurl.com/blnhsg")                           # => "http://www.google.com/search?q=number+of+horns+on+a+unicorn&ie=UTF-8"
    #   LongURL.expand("http://is.gd/iUKg")                                   # => "http://fabien.jakimowicz.com"
    #
    #   # not expandable urls, without any http call
    #   LongURL.expand("http://www.linuxfr.org")                              # => "http://www.linuxfr.org"
    #
    #   # not expandable urls, calling longurl.org only
    #   LongURL.expand("http://www.linuxfr.org", :try_unsupported => true)    # => "http://www.linuxfr.org/pub"
    #
    #   # not expandable urls, direct resolution only
    #   LongURL.expand("http://www.linuxfr.org", :direct_resolution => true)  # => "http://www.linuxfr.org/pub"
    #
    #   # not expandable urls, longurl.org and direct resolution
    #   LongURL.expand("http://www.linuxfr.org",
    #                  :try_unsupported => true, :direct_resolution => true)  # => "http://www.linuxfr.org/pub"
    # === Exceptions
    # * LongURL::InvalidURL : will occurs if given url is nil, empty or invalid
    # * LongURL::UnknownError : an unknown error occurs
    def expand(url, options = {})
      @@service ||= Service.new(:cache => options[:cache] || LongURL::Cache.new)
      options[:try_unsupported] ? @@service.query(url) : @@service.query_supported_service_only(url)
    rescue UnsupportedService
      options[:direct_resolution] ? Direct.follow_redirections(url) : url
    end
  end
  
end