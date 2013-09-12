module Projenitor::Commands

  class BuildCommand < BaseCommand

    dynamic { |template_name|

      command     :build

      usage       "build PATH"

      description "Build a new #{ template_name } project at PATH"

    }
    
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
    
    def initialize(template, path, args)
      @template = template
      @path     = path
      @options  = DynamicOptionParser.parse(args)
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run
      Projenitor::Template::Project.build(template, path, options)
    end

  end

end
