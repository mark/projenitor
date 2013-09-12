module Projenitor

  class CLI < Thor

    Commands::LinkCommand[self]
    
    Commands::CloneCommand[self]

    Dotfile.templates.each do |template|

      desc "#{ template } COMMAND", "Commands for the #{ template } generator"
      
      klass = Commands::TemplateCommandFactory.template_command(template)

      subcommand template, klass
    
    end

  end

end
