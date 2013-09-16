module Projenitor::Commands

  class BuildCommand < BaseCommand

    command     :build

    usage       "build PATH"

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
      "Build a new #{ template } project at PATH"
    end

    def run(*args)
      @path     = path
      @options  = DynamicOptionParser.parse(args)

      Projenitor::Template::Project.build(template, path, options)
    end

  end

end
