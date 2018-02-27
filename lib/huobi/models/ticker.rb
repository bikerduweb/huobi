module Huobi
  module Models
    class Ticker < Base
      attr_accessor :bid, :ask
      
      MAPPING  =   {
        amount:   :float,
        open:     :float,
        close:    :float,
        high:     :float,
        id:       :time,
        count:    :integer,
        low:      :float,
        version:  :integer,
        vol:      :float
      }
      
      INDEX_MAPPING = {
        0 => :price,
        1 => :volume
      }
      
      def initialize(hash)
        super(hash)
        
        [:bid, :ask].each do |type|
          convert_array(hash, type)
        end
      end
      
      def timestamp
        self.id
      end
      
      private
        def convert_array(hash, type)
          data    =   {}
        
          hash.fetch(type.to_s, [])&.each_with_index do |value, index|
            data[INDEX_MAPPING[index]] = value
          end
        
          self.send("#{type}=", data)
        end
      
    end
  end
end
