module Huobi
  module Utilities
    class Encoding
      
      class << self
                
        def sign(data, secret: ::Huobi.configuration.secret)
          Base64.encode64(OpenSSL::HMAC.digest('sha256', secret, data)).gsub("\n","")
        end
                  
      end
      
    end    
  end
end
