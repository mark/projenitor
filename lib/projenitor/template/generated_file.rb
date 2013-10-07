class Projenitor::Template

  class GeneratedFile

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :project, :local_path, :contents

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(project, local_path)
      @project    = project
      @local_path = local_path
      @contents   = []
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def absolute_path
      @absolute_path ||= project.absolute_path(local_path)
    end

    def build(options = {})
      string = contents.join("\n")
      write(string)
    end

    def file(filename)
      contents << File.read( project.template_path(filename) )
    end

    def text(string)
      contents << string
    end

    private

    def write(string)
      File.write(absolute_path, string)
    end

  end

end
