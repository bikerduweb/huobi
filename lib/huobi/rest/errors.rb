module Huobi
  module Rest
    module Errors
      
      def error?(response)
        if response.is_a?(Hash) && (response.has_key?("error") || response.has_key?("err-code"))
          error     =   response.fetch("error", response.fetch("err-code", nil))
          message   =   response.fetch("message", response.fetch("err-msg", nil))
          status    =   response.fetch("status", nil)
          
          if !error.to_s.empty?
            raise ::Huobi::Errors::ResponseError.new("#{error} (#{status}): #{message}")
          end
          
        end
      end
            
    end
  end  
end
