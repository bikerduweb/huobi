module Huobi
  module Rest
    module Public
      module Misc
        
        def system_time(options: {})
          ::Huobi::Utilities::Parsing.epoch_to_time(get("/v1/common/timestamp", options: options)&.fetch("data", {}), ms: true)
        end
      
      end
    end
  end
end
