# Copyright (c) 2009 by Fabien Jakimowicz (fabien@jakimowicz.com)
#
# Please see the LICENSE file for licensing.

require 'longurl/constants'
require 'longurl/exceptions'
require 'longurl/service'
require 'longurl/direct'

module LongURL
  
  class << self
    # Expand given <tt>url</tt> to a longest one.
    # First, expand will try to expand url using longurl.org service.
    # Then, it will try to direct follow redirections on the given url and returns final one.
    # === Types
    # <tt>url</tt> is expected to be a String and returns a String with the url.
    # === Examples
    #   # simple expands
    #   LongURL.expand("http://tinyurl.com/1c2")    # => "http://www.google.com"
    #   LongURL.expand("http://tinyurl.com/blnhsg") # => "http://www.google.com/search?q=number+of+horns+on+a+unicorn&ie=UTF-8"
    #   LongURL.expand("http://is.gd/iUKg")         # => "http://fabien.jakimowicz.com"
    #
    #   # not expandable urls
    #   LongURL.expand("http://www.linuxfr.org")    # => "http://www.linuxfr.org"
    # === Exceptions
    # * LongURL::InvalidURL : will occurs if given url is nil, empty or invalid
    # * LongURL::UnknownError : an unknown error occurs
    def expand(url)
      @@service ||= Service.new
      @@service.query(url)
    rescue UnsupportedService
      Direct.follow_redirections url
    end
  end
  
end