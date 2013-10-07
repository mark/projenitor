module Projenitor::Commands

  class ConfigCommand < BaseCommand

    command     :config

    usage       "config PATH"  

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :template, :path, :options

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(template)
      @template = template
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def description
      "Extract the configs for creating a #{ template.name } template at PATH"
    end

    def run(path)
      @path = path
      
      config_file     = File.join(Dir.pwd, "#{template_name}_configs.yml")
      config_contents = template.config_file
      locals          = { }

      runner = Projenitor::Template::ErbRunner.new(config_contents, locals)
    end

  end

end
