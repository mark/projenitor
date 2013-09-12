module Projenitor

  class CLI < Thor

    Commands::LinkCommand[self]
    
    Commands::CloneCommand[self]

    Dotfile.templates.each do |template|

      Commands::TemplateCommandFactory[self, template]
    
    end

  end

end
