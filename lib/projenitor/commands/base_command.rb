module Projenitor::Commands

  class BaseCommand

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.[](cli)
      define_on(cli)
    end
    
    def self.command(cmd = nil)
      @command ||= cmd
    end

    def self.command_summary(summary = nil)
      @summary ||= summary
    end
    
    def self.define_on(cli)
      command_class = self

      cli.desc command_summary, description
      cli.long_desc long_description
      cli.send(:define_method, command) { |*args| command_class.new(*args).run }
    end

    def self.description(short = nil)
      @short ||= short
    end

    def self.long_description(long = nil)
      @long ||= long
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
