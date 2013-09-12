module Projenitor::Commands

  class CloneCommand < BaseCommand

    command     :clone

    usage       "clone PATH"

    description "Copies directory or .zip at PATH into ~/.projenitor as a new projenitor template"
    
    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :path, :link_path

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(path)
      @path      = File.expand_path(path)
      @link_path = Projenitor::Dotfile.template_path(path)
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run
    end

  end

end
