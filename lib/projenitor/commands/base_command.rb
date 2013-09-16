module Projenitor::Commands

  class BaseCommand

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.[](cli, *args)
      command = self.new(*args)
      
      command.define_on(cli)
    end

    def self.command(cmd)
      define_method(:command) { cmd }
    end

    def self.description(short)
      define_method(:description) { short }
    end

    def self.long_description(long)
      define_method(:long_description) { long }
    end

    def self.usage(summary)
      define_method(:usage) { summary }
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def command
      raise NotImplementedError
    end

    def define_on(cli)
      command_object = self

      cli.desc(usage, description)
      cli.long_desc(long_description) unless long_description.empty?
      cli.send(:define_method, command) { |*command_args| command_object.run(*command_args) }
    end

    def description
      ''
    end

    def long_description
      ''
    end

    def run
      raise NotImplementedError
    end

    def usage
      ''
    end

  end

end
