require 'active_support/core_ext/string/inflections'

require 'projenitor/dotfile'
require 'projenitor/dynamic_option_parser'

require 'projenitor/template/template'

require 'projenitor/commands/base_command'
require 'projenitor/commands/build_command'
require 'projenitor/commands/clone_command'
require 'projenitor/commands/link_command'
require 'projenitor/commands/template_command'

require 'projenitor/cli'
require 'projenitor/reporter'

module Projenitor

  class << self
    attr_accessor :reporter
  end

  self.reporter = Reporter.new

end
