class Configure

  def initialize(root)
    @root = root
  end

  def set(configs)
    configure_keys(@root, configs)
  end

  private
  
  def configure_keys(object, hash)
    hash.each do |key, value|
      if value.kind_of? Hash
        child = object.send(key)

        configure_keys(child, value)
      else
        object.send "#{key}=", value
      end
    end
  end

end
