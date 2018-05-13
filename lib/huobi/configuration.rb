module Huobi
  class Configuration
    attr_accessor :api_host, :api_version
    attr_accessor :account_id, :key, :secret
    attr_accessor :signature_method, :signature_version
    attr_accessor :faraday

    def initialize
      self.api_host           =   "api.huobi.pro"
      self.api_version        =   1

      self.account_id         =   nil
      self.key                =   nil
      self.secret             =   nil

      self.signature_method   =   "HmacSHA256"
      self.signature_version  =   2

      self.faraday            =   {
        adapter:    :net_http,
        user_agent: 'Huobi Ruby',
        verbose:    false
      }
    end

    def verbose_faraday?
      self.faraday.fetch(:verbose, false)
    end
  end
end
