module Projenitor::Commands

  class TemplateCommand < BaseCommand

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :template

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(template)
      @template = template
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.generate_cli(class_name)
      Class.new(Thor).tap do |klass|
        self.const_set(class_name.classify, klass)
      end
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def command
      template
    end

    def define_subcommands(cli)
      BuildCommand[cli, template]
    end
    
    def define_on(cli)
      sub_cli = self.class.generate_cli(template)
      define_subcommands(sub_cli)

      cli.desc(usage, description)
      cli.long_desc(long_description) unless long_description.empty?

      cli.subcommand command, sub_cli
    end

    def description
      "Commands for projects using the #{ template } template"
    end
    
    def usage
      "#{ template } SUBCOMMAND ...ARGS"
    end

  end

end
