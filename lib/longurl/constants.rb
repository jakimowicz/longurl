require "uri"

module LongURL
  ShortURLMatchRegexp = /http:\/\/[\/\-_.a-z0-9]+/im

  # Urls for longurl
  EndPoint        = URI.parse("http://api.longurl.org/v1/expand")
  ServiceEndPoint = URI.parse("http://api.longurl.org/v1/services")
end