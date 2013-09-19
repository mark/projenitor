class Projenitor::Template

  class ManifestRunner

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :__project__, :options, :__registry__

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(root_path, template_name, options)
      @options        = options
      project_options = { skip: options.delete('skip'), force: options.delete('force') }

      @__project__    = Project.new(template_name, root_path, project_options)
      @__registry__   = Registry.new
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
            __registry__.build
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
      dir_mapping = __project__.dir(local_path)

      __registry__.register(dir_mapping, options)
    end

    def file(local_path, template_file, options = {})
      file_mapping = __project__.file(template_file, local_path)

      __registry__.register(file_mapping, options)
      __registry__.dependency(file_mapping.dir)
    end

    def project
      __project__.project_name
    end

  end

end
