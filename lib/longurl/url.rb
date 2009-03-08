require 'uri'
require "longurl/exceptions"

module LongURL
  module URL
    # Check given <tt>url</tt>
    # Raises LongURL::InvalidURL if <tt>url</tt> is invalid.
    # Returns a parsed http uri object on success.
    def self.check(url)
      raise LongURL::InvalidURL if url.nil? or url.empty?
      result = URI.parse(url)
      raise LongURL::InvalidURL unless result.is_a?(URI::HTTP)
      result
    rescue URI::InvalidURIError
      raise LongURL::InvalidURL
    end
  end
end