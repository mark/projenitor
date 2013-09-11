require 'yaml'

module Env

  class << self
    attr_accessor :bot
  end

  module Bot

    CONFIG_FILE = "config/bot.yml"

    def self.start!
      configs       = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', CONFIG_FILE))
      bot_configs   = configs['bot']

      assign_channels bot_configs
      assign_plugins  bot_configs

      Env.bot = Cinch::Bot.new do
        configure do |c|
          Configure.new(c).set(bot_configs)
        end
      end

      Env.bot.start
    end

    private

    def self.assign_channels(configs)
      # Nothing right now...
    end

    def self.assign_plugins(configs)
      configs['plugins']['plugins'].map! &:constantize
    end

  end

end
