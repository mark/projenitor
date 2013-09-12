module Projenitor::Template

  class DirMapping

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :mapper, :local_path

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(mapper, local_path)
      @mapper     = mapper
      @local_path = local_path
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def absolute_path
      @absolute_path ||= mapper.absolute_path(local_path)
    end

    def exists?
      File.directory?(absolute_path)
    end

    def build(options = {})
      if File.directory?(absolute_path)
        puts "\tEXISTS\t#{ absolute_path }"
      elsif File.exists?(absolute_path)
        puts "\tERROR\t#{ absolute_path } exists and is not a directory"
        exit
      else
        puts "\tCREATE\t#{ absolute_path }"
        FileUtils.makedirs(absolute_path)
      end
    end

  end

end
