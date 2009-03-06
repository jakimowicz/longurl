require "net/http"

module LongURL
  module Direct
    # Will follow redirections given url <tt>orig</tt>.
    # === Exceptions
    # * LongURL::NetworkError in case of a network error (timeout, socket error, ...)
    # * LongURL::InvalidURL in case of a bad url (nil, empty, not http scheme ...)
    def self.follow_redirections(orig)
      uri = LongURL::URL.check(orig)
      Net::HTTP.start(uri.host, uri.port) do |http|
        answer = http.get(uri.path.empty? ? '/' : uri.path)
        dest = answer['Location']
        (dest && dest[0, 7] == 'http://' && follow_redirections(dest)) || orig
      end
    rescue Timeout::Error, Errno::ENETUNREACH, Errno::ETIMEDOUT, SocketError
      raise LongURL::NetworkError
    end
  end
end