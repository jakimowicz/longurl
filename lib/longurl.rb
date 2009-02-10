# Copyright (c) 2009 by Fabien Jakimowicz (fabien@jakimowicz.com)
#
# Please see the LICENSE file for licensing.

require 'longurl/constants'
require 'longurl/exceptions'
require 'longurl/service'
require 'longurl/direct'

module LongURL
  
  class << self
    def expand(url)
      @@service ||= Service.new
      @@service.query(url)
    rescue UnsupportedService
      Direct.follow_redirections url
    end
  end
  
end