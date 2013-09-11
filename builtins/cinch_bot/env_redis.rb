require 'yaml'

module Env

  class << self
    attr_accessor :redis
  end

  module Redis

    CONFIG_FILE = "config/redis.yml"

    def self.start!
      configs       = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', CONFIG_FILE))
      redis_configs = configs['redis']
      Env.redis     = ::Redis.new redis_configs
    end

  end

end
