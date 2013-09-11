module Projenitor::Template

  class ManifestRunner

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :mapper, :options

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(root_path, template_name, options)
      @options = options
      @mapper  = ProjectMapper.new(template_name, root_path)
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.create_template_class(template)
      manifest_file     = Projenitor::Dotfile.template_manifest_path(template)
      manifest_contents = File.read(manifest_file)

      klass = Class.new(self) do
        class_eval(<<-RUBY, manifest_file, 0)
          def self.name
            #{ template.classify }
          end

          def build
            directory('.')
            #{ manifest_contents }
          end
        RUBY
      end
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def directory(local_path, options = {})
      dir_mapping = mapper.dir(local_path)

      dir_mapping.build(options)
    end

    def file(local_path, template_file, options = {})
      file_mapping = mapper.file(template_file, local_path)

      file_mapping.build(options)
    end

    def project
      mapper.project_name
    end

  end

end
