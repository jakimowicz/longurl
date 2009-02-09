require "net/http"
require "cgi"
require "json"

module LongURL

  class Service

    def query(url)
      Net::HTTP.start(EndPoint.host, EndPoint.port) do |http|
        handle_response http.get("#{EndPoint.path}?format=json&url=#{CGI.escape(url)}")
      end
    end
        
    protected
    
    def handle_response(response)
      parsed = JSON.parse(response.body)
      if parsed['long_url']
        parsed['long_url']
      elsif parsed['message'] # Error
        raise LongURL::UnsupportedService if parsed['messages']['message'] == 'Unsupported service.'
      else
        raise LongURL::UnknownError
      end
    end

  end  

end