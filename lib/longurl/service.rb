require "net/http"
require "cgi"
require "uri"
require "rubygems"
require "json"
require "longurl/constants"
require "longurl/exceptions"

module LongURL

  class Service
    
    def initialize(params = {})
      @@cache = params[:cache]

      @@supported_services = @@cache.get('supported_services')
      @@supported_services ||= @@cache.set('supported_services', fetch_supported_services)
    end
    
    def query_supported_service_only(url)
      check url
      raise LongURL::UnsupportedService unless service_supported?(url)
      cached_query url
    end
    
    def cached_query(url)
      @@cache.get(url) || @@cache.set(url, query(url))
    end

    def query(url)
      escaped_url = check_and_escape(url)
      Net::HTTP.start(EndPoint.host, EndPoint.port) do |http|
        handle_response http.get("#{EndPoint.path}?format=json&url=#{escaped_url}")
      end
    rescue Timeout::Error, Errno::ENETUNREACH
      raise LongURL::NetworkError
    end
        
    def service_supported?(url)
      @@supported_services.include? URI.parse(url).host.downcase
    end
    
    def check(url)
      raise LongURL::InvalidURL if url.nil? or url.empty?
    end

    protected
    
    def check_and_escape(url)
      check url
      CGI.escape url
    end
    
    def fetch_supported_services
      Net::HTTP.start(ServiceEndPoint.host, ServiceEndPoint.port) do |http|
        response = http.get("#{ServiceEndPoint.path}?format=json")
        parsed = JSON.parse(response.body)
        parsed.values.flatten
      end
    rescue Timeout::Error, Errno::ENETUNREACH
      raise LongURL::NetworkError
    end
    
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