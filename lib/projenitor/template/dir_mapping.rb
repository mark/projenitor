module Projenitor::Template

  class DirMapping

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :project, :local_path

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(project, local_path)
      @project    = project
      @local_path = local_path
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def absolute_path
      @absolute_path ||= project.absolute_path(local_path)
    end

    def exists?
      File.directory?(absolute_path)
    end

    def build(options = {})
      if File.directory?(absolute_path)
        Projenitor.reporter.report(:exists, absolute_path)
      elsif File.exists?(absolute_path)
        Projenitor.reporter.report(:error, absolute_path)
        exit
      else
        Projenitor.reporter.report(:create, absolute_path)
        FileUtils.makedirs(absolute_path)
      end
    end

  end

end
