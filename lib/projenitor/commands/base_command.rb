module Projenitor::Commands

  class BaseCommand

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.[](cli, *args)
      if @dynamic
        dynamic_definition = CommandDefinition.new(self)
        dynamic_definition.dynamic(@dynamic)
        dynamic_definition.define_on(cli, *args)
      else
        defn.define_on(cli, *args)
      end
    end

    def self.command(cmd)
      defn.command cmd
    end

    def self.defn
      @defn ||= CommandDefinition.new(self)
    end

    def self.dynamic(&block)
      @dynamic = block
    end

    def self.description(short)
      defn.description short
    end

    def self.long_description(long)
      defn.long_description long
    end

    def self.usage(summary)
      defn.usage summary
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run
      raise NotImplementedError
    end

  end

end
