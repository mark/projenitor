module Projenitor

  class CLI < Thor

    desc *LinkCommand.desc

    def link(path)
      LinkCommand.execute(path)
    end

    desc *Projenitor::Commands::CloneCommand.desc

    def clone(path)
      Projenitor::Commands::CloneCommand.execute(path)
    end

    Dotfile.templates.each do |template|

      desc "#{ template } COMMAND", "Commands for the #{ template } generator"
      
      subcommand template, TemplateCommand.create_command_class(template)
    
    end

  end

end
