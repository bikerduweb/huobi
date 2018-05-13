module Huobi
  module Rest
    module Public
      module Orders

        def order_depth(symbol, type: "step0", options: {})
          symbol      =   ::Huobi::Utilities::Parameters.fix_symbol(symbol)
          response    =   get("/market/depth", params: {symbol: symbol, type: type}, options: options)&.fetch("tick", {})&.merge("symbol" => symbol)
          ::Huobi::Models::OrderBook.new(response) if response
        end

        def orders(symbol, options: {})
          options[:authenticate] = true
          symbol = ::Huobi::Utilities::Parameters.fix_symbol(symbol) if symbol
          params =  { symbol: symbol }.merge(options.delete(:params) || {})
          params[:states] ||= "filled"
          params.delete_if { |key, value| value.nil? }
          response    =   get("/v1/order/orders", params: params, options: options)&.fetch("data", {})
        end
      end
    end
  end
end
