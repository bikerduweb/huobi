module Huobi
  module Models
    class Symbol < Base
      MAPPING  =   {
        base_currency:    :string,
        quote_currency:   :string,
        price_precision:  :integer,
        amount_precision: :integer,
        symbol_partition: :string
      }
    end
  end
end
