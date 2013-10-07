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
    
    def initialize(template_name)
      @template = Projenitor::Dotfile[template_name]
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
      template.name
    end

    def define_base_methods(cli)
      template_obj = template

      cli.class_eval {
        no_commands {
          define_method(:template) do
            template_obj
          end
        }
      }
    end

    def define_subcommands(cli)
      BuildCommand[cli, template.name]

      if template.commands_file
        cli.class_eval(template.commands_file)
      end
    end
    
    def define_on(cli)
      sub_cli = self.class.generate_cli(template.name)
      define_base_methods(sub_cli)
      define_subcommands(sub_cli)

      cli.desc(usage, description)
      cli.long_desc(long_description) unless long_description.empty?

      cli.subcommand command, sub_cli
    end

    def description
      "Commands for projects using the #{ template.name } template"
    end
    
    def usage
      "#{ template.name } SUBCOMMAND ...ARGS"
    end

  end

end
