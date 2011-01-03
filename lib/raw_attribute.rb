module RawAttribute
  extend ActiveSupport::Concern
  IGNORE_ATTRIBUTES = ["id", "created_at", "updated_at"]
  class RawAttributeInvalidColumnType < Exception; end
  
  module ClassMethods
    def raw_attribute(*args)
      options = args.extract_options!

      case args.first
        when :all then
          attrs = self.new.attribute_names
        else
          attrs = args
      end

      attrs -= options[:except] if options.has_key? :except
      attrs -= IGNORE_ATTRIBUTES

      attrs.each do |a|
        if self.columns_hash[a.to_s].text?
          class_eval <<-STR, __FILE__, __LINE__ + 1
          def #{a}
            read_attribute('#{a}'.to_sym).to_s.html_safe
          end
          STR
        else
          raise RawAttributeInvalidColumnType.new("Cant use columns other than text or strings as raw, invalid column type #{a}")
        end
      end
    end

  end # end of module#ClassMethods
end

ActiveRecord::Base.send(:include, RawAttribute)

