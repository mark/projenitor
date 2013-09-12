module Projenitor::Commands

  module TemplateCommandFactory

    ##################
    #                #
    # Module Methods #
    #                #
    ##################
    
    def self.[](cli, template)
      cli.desc "#{ template } COMMAND", "Commands for #{ template } project template"

      cli.subcommand template, factory(template)
    end

    def self.factory(template)
      klass = Class.new(Thor) do

        def self.template_name(template = nil)
          @template ||= template
        end

        def self.namespace
          template_name
        end

      end.tap do |klass|
        klass.template_name template

        BuildCommand[klass, template]
      end
    end

  end

end
