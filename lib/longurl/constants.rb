require "uri"

module LongURL
  EndPoint        = URI.parse("http://api.longurl.org/v1/expand")
  ServiceEndPoint = URI.parse("http://api.longurl.org/v1/services")
end