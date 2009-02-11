module LongURL
  # Raised by LongURL::Service class if longurl.org service returns unsupported service error.
  class UnsupportedService < StandardError
  end

  # Raised by LongURL::Service class if longurl.org service returns a not supported answer.
  class UnknownError < StandardError
  end
  
  # Raised by LongURL::Service if supplied url is invalid (nil, empty, ...)
  class InvalidURL < StandardError
  end
  
  # Raised if a network error occurs : timeout, unreachable network, ...
  class NetworkError < StandardError
  end
end