module Huobi
  module Rest
    module Public
      module Trades
        
        def latest_trade(symbol, options: {})
          symbol      =   ::Huobi::Utilities::Parameters.fix_symbol(symbol)
          response    =   get("/market/trade", params: {symbol: symbol}, options: options)&.dig("tick", "data")
          ::Huobi::Models::Trade.parse(response) if response
        end
        
        # Size: 1..2000
        def trades(symbol, size: 100, options: {})
          symbol      =   ::Huobi::Utilities::Parameters.fix_symbol(symbol)
          response    =   get("/market/history/trade", params: {symbol: symbol, size: size}, options: options)&.fetch("data", [])
          ::Huobi::Models::Trade.parse(response) if response
        end
      
      end
    end
  end
end
