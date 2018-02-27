module Huobi
  module Rest
    module Public
      module Orders
        
        def order_depth(symbol, type: "step0", options: {})
          symbol      =   ::Huobi::Utilities::Parameters.fix_symbol(symbol)
          response    =   get("/market/depth", params: {symbol: symbol, type: type}, options: options)&.fetch("tick", {})&.merge("symbol" => symbol)
          ::Huobi::Models::OrderBook.new(response) if response
        end
      
      end
    end
  end
end
