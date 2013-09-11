module DynamicOptionParser

  FLAG = /^--?(.+)$/

  class MissingOptionName < StandardError; end

  def self.parse(options)
    Hash.new.tap do |hash|
      parse_option(hash, options) until options.empty?
    end
  end

  private

  def self.parse_option(hash, options)
    option = options.shift

    if option =~ FLAG
      key   = $1
      value = options.shift
      
      if value =~ FLAG
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
