module Huobi
  module Models
    class OHLCV < Base
      attr_accessor :timestamp
      
      MAPPING   =   {
        id:         :string,
        version:    :string,
        open:       :float,
        high:       :float,
        low:        :float,
        close:      :float,
        amount:     :float,
        vol:        :float,
        count:      :integer
      }
      
      def initialize(hash)
        super(hash)
        
        if hash.has_key?("ts")
          self.timestamp  =   ::Huobi::Utilities::Parsing.epoch_to_time(hash.fetch("ts", nil), ms: true)
        else
          self.timestamp  =   ::Huobi::Utilities::Parsing.epoch_to_time(hash.fetch("id", nil), ms: false)
        end
        
      end
      
    end
  end
end
