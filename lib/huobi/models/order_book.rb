module Huobi
  module Models
    class OrderBook
      attr_accessor :symbol, :timestamp, :asks, :bids
      
      INDEX_MAPPING         =   {
        0 => :price,
        1 => :amount
      }
      
      def initialize(hash, type: :nil)
        self.symbol         =   hash.fetch("symbol", nil)
        self.timestamp      =   ::Huobi::Utilities::Parsing.epoch_to_time(hash.fetch("ts", nil), ms: true) if hash.has_key?("ts") && !hash.fetch("ts", nil).to_s.empty?

        self.bids           =   []
        self.asks           =   []

        process(hash, type: type)
      end
      
      def process(data, type: nil)
        if data.is_a?(Hash)
          ["bids", "asks"].each do |type|
            process_orders(data.fetch(type.to_s, []), type: type)
          end
        elsif data.is_a?(Array)
          process_orders(data, type: type)
        end
      end
      
      def process_orders(orders, type: "bids")
        sum             =   0
        
        orders.each do |item|
          data          =   {}
          
          item.each_with_index do |value, index|
            data[INDEX_MAPPING[index]] = value
          end
          
          sum          +=   data[:amount]
          data[:sum]    =   sum
          
          data[:value]  =   (data[:price] * data[:amount])
          
          case type
            when "bids"
              self.bids << data
            when "asks"
              self.asks << data
          end
        end
      end

    end
  end
end
