module LongURL
  # Raised by LongURL::Service class if longurl.org service returns unsupported service error.
  class UnsupportedService < Exception
  end

  # Raised by LongURL::Service class if longurl.org service returns a not supported answer.
  class UnknownError < Exception
  end
  
  # Raised by LongURL::Service if supplied url is invalid (nil, empty, ...)
  class InvalidURL < Exception
  end
end