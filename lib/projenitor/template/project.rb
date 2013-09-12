module Projenitor::Template

  class Project

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :template_name, :local_root

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(template_name, local_root)
      @template_name = template_name
      @local_root    = local_root
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def build(template, path, options)
      klass   = ManifestRunner.create_template_class(template)
      builder = klass.new(path, template, options)

      builder.build
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def absolute_path(local_path)
      File.join(local_root, local_path)
    end

    def dir(local_path_or_dir)
      if local_path_or_dir.kind_of?(DirMapping)
        local_path_or_dir
      else
        DirMapping.new(self, local_path_or_dir)
      end
    end

    def file(template_file, local_path)
      FileMapping.new(self, template_file, local_path)
    end

    def project_name
      File.basename(local_root)
    end

    def template_path(template_file)
      File.join(Dir.home, '.projenitor', template_name, template_file)
    end

  end

end
