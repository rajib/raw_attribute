class ActiveRecord::Base
  IGNORE_ATTRIBUTES = ["id", "created_at", "updated_at"]

  def self.raw_attribute(*args)
    options = args.extract_options!

    case args.first
      when :all then attrs = self.new.attribute_names
      else           attrs = args
    end

    attrs -= options[:except] if options.has_key? :except
    attrs -= IGNORE_ATTRIBUTES

    attrs.each do |a|
      define_method :"#{a}=" do |value|
        write_attribute("#{a}", RawHtml::Base.raw(value))
      end
    end
  end
end


module RawHtml
  class Base
    def self.raw(str)
      str.to_s.html_safe
    end
  end
end

