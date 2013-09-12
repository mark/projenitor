module Projenitor::Commands

  class BuildCommand

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

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.desc(template_name)
      ["build PATH", "Build a new #{ template_name } project at PATH"]
    end

    def self.execute(*args)
      new(*args).run
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