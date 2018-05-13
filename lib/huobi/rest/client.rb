module Huobi
  module Rest
    class Client
      attr_accessor :url, :configuration

      def initialize(configuration: ::Huobi.configuration)
        self.configuration    =   configuration
        self.url              =   "https://#{self.configuration.api_host}"
      end

      include ::Huobi::Rest::Errors
      include ::Huobi::Rest::Authentication

      include ::Huobi::Rest::Public::Markets
      include ::Huobi::Rest::Public::Klines
      include ::Huobi::Rest::Public::Orders
      include ::Huobi::Rest::Public::Trades
      include ::Huobi::Rest::Public::Misc

      include ::Huobi::Rest::Private::Accounts

      def configured?
        !self.configuration.key.to_s.empty? && !self.configuration.secret.to_s.empty?
      end

      def check_credentials!
        unless configured?
          raise ::Huobi::Errors::MissingConfigError.new("Huobi gem hasn't been properly configured.")
        end
      end

      def to_uri(path)
        "#{self.url}#{path}"
      end

      def parse(response)
        error?(response)
        response
      end

      def get(path, params: {}, options: {})
        request path, method: :get, params: params, options: options
      end

      def post(path, params: {}, data: {}, options: {})
        request path, method: :post, params: params, data: data, options: options
      end

      def request(path, method: :get, params: {}, data: {}, options: {})
        path = path.gsub('/hadax/', '/') unless hadax?

        should_auth   =   options.fetch(:authenticate, false)
        user_agent    =   options.fetch(:user_agent, self.configuration.faraday.fetch(:user_agent, nil))
        proxy         =   options.fetch(:proxy, nil)

        params        =   authenticate!(method: method, path: path, params: params) if should_auth
        url           =   to_uri(path)

        connection    =   Faraday.new(url: url) do |builder|
          builder.headers["User-Agent"]       =   user_agent if !user_agent.to_s.empty?
          builder.headers["Accept-Language"]  =   "en-US"

          builder.request  :url_encoded if method.eql?(:post)
          builder.response :logger      if self.configuration.verbose_faraday?
          builder.response :json

          if proxy
            puts "[Huobi::Rest::Client] - Will connect to Huobi using proxy: #{proxy.inspect}" if self.configuration.verbose_faraday?
            builder.proxy = proxy
          end

          builder.adapter self.configuration.faraday.fetch(:adapter, :net_http)
        end

        response = case method
        when :get
          connection.get do |request|
            request.params  =   params if params && !params.empty?
          end&.body
        when :post
          connection.post do |request|
            request.body    =   data
            request.params  =   params if params && !params.empty?
          end&.body
        end

        parse(response)
      end

      private

      def hadax?
        @hadax ||= url.to_s.match(/hadax/im) ? true : false
      end
    end
  end
end
