module Huobi
  module Utilities
    class Parameters
      
      class << self
                
        def hash_sort(hash)
          Hash[hash.sort_by { |key, value| key } ]
        end
        
        def fix_symbol(symbol)
          symbol.gsub("-", "").gsub("_", "").downcase
        end
                  
      end
      
    end    
  end
end
