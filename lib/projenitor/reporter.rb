module Projenitor

  class Reporter

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :target

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(target = STDOUT)
      @target = target
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def report(action, path)
      action = action.to_s.upcase.ljust(12)
      puts "\t#{ action }#{ path }"
    end

  end

end
