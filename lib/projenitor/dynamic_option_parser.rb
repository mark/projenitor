module DynamicOptionParser

  FLAG = /^--?(.+)$/

  class MissingOptionName < StandardError; end

  def self.parse(options)
    Hash.new.tap do |hash|
      while options.any?
        parse_option(hash, options)
      end
    end
  end

  private

  def self.parse_option(hash, options)
    option = options.shift

    if option =~ FLAG
      key   = $1
      value = options.shift
      
      if value.nil? || value =~ FLAG
        options.unshift(value)
        value = true
      end

      hash[key] = value
    else
      msg = "ERROR: No option name for #{ option }"
      raise MissingOptionName, msg
    end
  end

end
