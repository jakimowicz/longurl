require "net/http"
require "longurl/url"
require "longurl/exceptions"

module LongURL
  module Direct
    # Will follow redirections given url <tt>orig</tt>.
    # === Exceptions
    # * LongURL::NetworkError in case of a network error (timeout, socket error, ...)
    # * LongURL::InvalidURL in case of a bad url (nil, empty, not http scheme ...)
    # * LongURL::TooManyRedirections if there are too many redirection for destination
    def self.follow_redirections(orig, limit = 5)
      raise LongURL::TooManyRedirections if limit == 0
      uri = LongURL::URL.check(orig)
      Net::HTTP.start(uri.host, uri.port) do |http|
        answer = http.get(uri.path.empty? ? '/' : uri.path)
        dest = answer['Location']
        (dest && dest[0, 7] == 'http://' && follow_redirections(dest, limit - 1)) || orig
      end
    rescue Timeout::Error, Errno::ENETUNREACH, Errno::ETIMEDOUT, SocketError
      raise LongURL::NetworkError
    rescue
      raise LongURL::UnknownError
    end
  end
end