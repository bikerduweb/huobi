# Rest API
require "faraday"
require "faraday_middleware"

# Shared
require "openssl"
require "base64"
require "addressable/uri"
require "json"
require "date"

require "huobi/version"

require "huobi/configuration"
require "huobi/errors"
require "huobi/constants"

require "huobi/utilities/parsing"
require "huobi/utilities/encoding"
require "huobi/utilities/parameters"

require "huobi/models/base"
require "huobi/models/symbol"
require "huobi/models/order_book"
require "huobi/models/ohlcv"
require "huobi/models/ticker"
require "huobi/models/trade"

require "huobi/rest/public/markets"
require "huobi/rest/public/klines"
require "huobi/rest/public/orders"
require "huobi/rest/public/trades"
require "huobi/rest/public/misc"

require "huobi/rest/private/accounts"

require "huobi/rest/errors"
require "huobi/rest/authentication"
require "huobi/rest/client"

if !String.instance_methods(false).include?(:underscore)
  require "huobi/extensions/string"
end

if !Hash.instance_methods(false).include?(:symbolize_keys)
  require "huobi/extensions/hash"
end

module Huobi
  
  class << self
    attr_writer :configuration
  end
  
  def self.configuration
    @configuration ||= ::Huobi::Configuration.new
  end

  def self.reset
    @configuration = ::Huobi::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
  
end
