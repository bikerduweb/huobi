module Huobi
  module Rest
    module Public
      module Klines
        
        # Symbol: trading symbol, e.g. itceth
        # Period: 1min, 5min, 15min, 30min, 60min, 1day, 1mon, 1week, 1year
        # Size: 1..2000
        def klines(symbol, period: "1min", size: 150, options: {})
          params    =   {
            symbol:   ::Huobi::Utilities::Parameters.fix_symbol(symbol),
            period:   period,
            size:     size,
          }
          
          params.delete_if { |key, value| value.nil? }
          
          response  =   get("/market/history/kline", params: params, options: options)&.fetch("data", [])
          ::Huobi::Models::OHLCV.parse(response) if response
        end
      
      end
    end
  end
end
