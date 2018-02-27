module Huobi
  module Models
    class Base
      
      def initialize(hash, use_ms_for_time: false)
        self.class::MAPPING.keys.each { |key| self.class.send(:attr_accessor, key) }
        
        hash.each do |key, value|
          key             =     key.to_s.underscore.to_sym
          type            =     self.class::MAPPING.fetch(key, nil)
          value           =     value && type ? ::Huobi::Utilities::Parsing.convert_value(value, type, use_ms_for_time: use_ms_for_time) : value
          self.send("#{key}=", value) if self.respond_to?(key)
        end
      end
      
      def attributes
        Hash[instance_variables.map { |name| [name.to_s.gsub(/^@/, "").to_sym, instance_variable_get(name)] }]
      end
      
      def self.parse(data)
        data&.collect { |item| self.new(item) }
      end
      
    end
  end
end
