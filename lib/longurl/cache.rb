module LongURL
  class Cache < Hash
    alias :get :[]
    alias :set :[]=
  end
end