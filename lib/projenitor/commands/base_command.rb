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
    
    def command_arguments
      meth       = self.class.instance_method(:run)
      params     = meth.parameters.map { |param| param.last }
      params[-1] = '*args' if params[-1] == :args

      params.join(', ')
    end

    def define_on(cli)
      command_object = self

      cli.desc(usage, description)
      cli.long_desc(long_description) unless long_description.empty?

      cli.instance_variable_set "@__#{command}__", self

      cli.class_eval <<-RUBY
        def self.__#{ command }__
          @__#{ command }__
        end

        def #{ command }(#{ command_arguments })
          self.class.__#{ command }__.run(#{ command_arguments })
        end
      RUBY

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
