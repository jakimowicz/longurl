require 'uri'
require "net/http"

module LongURL
  module Direct
    def self.follow_redirections(orig)
      uri = URI.parse(orig)
      Net::HTTP.start(uri.host, uri.port) do |http|
        answer = http.get(uri.path.empty? ? '/' : uri.path)
        dest = answer['Location']
        (dest && dest[0, 7] == 'http://' && follow_redirections(dest)) || orig
      end
    end
  end
end