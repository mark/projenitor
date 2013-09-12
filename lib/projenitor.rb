require 'projenitor/dotfile'
require 'projenitor/dynamic_option_parser'

require 'projenitor/template/manifest_runner'
require 'projenitor/template/file_handler'
require 'projenitor/template/erb_runner'
require 'projenitor/template/project'
require 'projenitor/template/file_mapping'
require 'projenitor/template/dir_mapping'
require 'projenitor/template/registry'

require 'projenitor/commands/base_command'
require 'projenitor/commands/command_definition'
require 'projenitor/commands/build_command'
require 'projenitor/commands/clone_command'
require 'projenitor/commands/link_command'
require 'projenitor/commands/template_command_factory'

require 'projenitor/cli'

require 'active_support/core_ext/string/inflections'
