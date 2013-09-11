module Projenitor

  class CLI < Thor

    desc *LinkCommand.desc

    def link(path)
      LinkCommand.execute(path)
    end

    Dotfile.templates.each do |template|

      desc "#{ template } COMMAND", "Commands for the #{ template } generator"
      
      subcommand template, TemplateCommand.create_command_class(template)
    
    end

  end

end
