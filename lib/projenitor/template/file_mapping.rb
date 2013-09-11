module Projenitor::Template

  class FileMapping

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :mapper, :template_file, :local_path

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(mapper, template_file, local_path)
      @mapper        = mapper
      @template_file = template_file
      @local_path    = local_path
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def absolute_path
      @absolute_path ||= mapper.absolute_path(local_path)
    end

    def build(options = {})            
      dir.build

      puts "CREATE: #{ absolute_path }"

      locals  = options.fetch(:locals) { Hash.new }
      locals  = locals.merge local_options
      handler = FileHandler[ File.extname(template_file) ]

      handler.process(self, locals)

      chmod options[:chmod]
    end

    def chmod(mod)
      return if mod.nil?

      FileUtils.chmod mod, absolute_path
    end

    def dir
      mapper.dir File.dirname(local_path)
    end

    def exists?
      File.exists?(absolute_path)
    end

    def ext
      File.extname(local_path)
    end

    def filename
      File.basename(local_path, ext)
    end

    def local_options
      { project: mapper.project_name, filename: filename }
    end

    def template_path
      @template_path ||= mapper.template_path(template_file)
    end

    def read_from_template
      File.read(template_path)
    end

    def write_to_project(string)
      File.write(absolute_path, string)
    end

  end

end
