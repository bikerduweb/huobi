module Huobi
  module Rest
    module Authentication

      def authenticate!(method: :get, path: nil, params: {})
        auth                  =   {
          "AccessKeyId"         =>  self.configuration.key,
          "SignatureMethod"     =>  self.configuration.signature_method,
          "SignatureVersion"    =>  self.configuration.signature_version,
          "Timestamp"           =>  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S")
        }

        params                =   params.merge(auth)
        params["Signature"]   =   sign(method: method, path: path, params: params)

        return params
      end

      def sign(method: :get, path: nil, params: {})
        params            =   ::Huobi::Utilities::Parameters.hash_sort(params)
        data              =   "#{method.to_s.upcase}\n#{self.configuration.api_host}\n#{path}\n#{build_query(params)}"
        if self.configuration.verbose_faraday?
          puts "DATA:"
          puts data
        end
        ::Huobi::Utilities::Encoding.sign(data, secret: self.configuration.secret)
      end

      def build_query(params)
        return params unless params.is_a? Hash
        uri               =   Addressable::URI.new
        uri.query_values  =   params
        uri.query
      end

    end
  end
end
