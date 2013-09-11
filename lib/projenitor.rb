require 'projenitor/dotfile'
require 'projenitor/dynamic_option_parser'

require 'projenitor/template/template'
require 'projenitor/template/erb_runner'

require 'projenitor/build_command'
require 'projenitor/link_command'
require 'projenitor/template_command'

require 'active_support/core_ext/string/inflections'

class Projenitor < Thor

  desc *LinkCommand.desc

  def link(path)
    LinkCommand.execute(path)
  end

  Dotfile.templates.each do |template|

    desc "#{ template } COMMAND", "Commands for the #{ template } generator"
    
    subcommand template, TemplateCommand.create_command_class(template)
  
  end

end
