module Huobi
  module Models
    class Trade < Base
      MAPPING   =   {
        amount:     :float,
        ts:         :time,
        id:         :string,
        price:      :float,
        direction:  :symbol
      }
      
      def initialize(hash)
        hash    =   hash.fetch("data", [])&.first
        super(hash, use_ms_for_time: true)
      end
      
    end
  end
end
