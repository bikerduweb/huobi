module Huobi
  module Rest
    module Public
      module Markets

        def symbols(options: {})
          response    =   get("/v1/hadax/common/symbols", options: options)&.fetch("data", [])
          ::Huobi::Models::Symbol.parse(response) if response
        end

        def currencies(options: {})
          response    =   get("/v1/hadax/common/currencys", options: options)&.fetch("data", [])
        end

        def ticker(symbol, options: {})
          symbol      =   ::Huobi::Utilities::Parameters.fix_symbol(symbol)
          response    =   get("/market/detail/merged", params: {symbol: symbol}, options: options)&.fetch("tick", {})
          ::Huobi::Models::Ticker.new(response) if response
        end

        def market_detail(symbol, options: {})
          symbol      =   ::Huobi::Utilities::Parameters.fix_symbol(symbol)
          response    =   get("/market/detail", params: {symbol: symbol}, options: options)
          response    =   response&.fetch("tick", {})&.merge("ts" => response&.fetch("ts", nil))
          ::Huobi::Models::OHLCV.new(response) if response
        end

      end
    end
  end
end
