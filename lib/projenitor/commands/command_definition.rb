module Projenitor::Commands

  class CommandDefinition

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(command_class)
      @command_class = command_class
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def command(cmd = nil)
      @command ||= cmd
    end

    def define_on(cli, *args)
      command_class = @command_class

      self.instance_exec(*args, &@block) if @block
        
      cli.desc usage, description
      cli.long_desc long_description
      cli.send(:define_method, command) { |*args| command_class.new(*args).run }
    end

    def dynamic(block)
      @block = block
    end

    def description(short = nil)
      @short ||= short
    end

    def long_description(long = nil)
      @long ||= long
    end

    def usage(summary = nil)
      @summary ||= summary
    end
    
  end

end
