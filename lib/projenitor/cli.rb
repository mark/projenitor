module Projenitor

  class CLI < Thor

    Commands::LinkCommand[self]
    
    Commands::CloneCommand[self]

    Dotfile.templates.each do |template|

      desc "#{ template } COMMAND", "Commands for the #{ template } generator"
      
      subcommand template, Projenitor::Commands::TemplateCommand.create_command_class(template)
    
    end

  end

end
