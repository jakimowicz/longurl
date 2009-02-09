# Copyright (c) 2009 by Fabien Jakimowicz (fabien@jakimowicz.com)
#
# Please see the LICENSE file for licensing.

require 'longurl/constants'
require 'longurl/exceptions'
require 'longurl/service'

module LongURL
  
  class << self
    def expand(url)
      @@service ||= Service.new
      @@service.query(url)
    end
  end
  
end