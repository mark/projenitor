module Projenitor::Template

  class FileMapping

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :project, :template_file, :local_path

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(project, template_file, local_path)
      @project       = project
      @template_file = template_file
      @local_path    = local_path
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
      project.dir File.dirname(local_path)
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

    def handle_exists(current_contents, new_contents)
      if project.skip?
        Projenitor.reporter.report(:skip, absolute_path)
      elsif project.force?
        Projenitor.reporter.report(:replace, absolute_path)
        write(new_contents)
      else
        Projenitor.reporter.report(:exists, absolute_path)
        done = false

        until done
          print "\t  [R]eplace, [S]kip, [D]iff, [Q]uit? "
          input = STDIN.gets.chomp[0].to_s.downcase

          case input
          when 'r'
            Projenitor.reporter.report(:replace, absolute_path)
            write(new_contents)
            done = true
          when 's'
            Projenitor.reporter.report(:skip, absolute_path)
            done = true
          when 'd'
            puts Diffy::Diff.new(current_contents, new_contents)
          when 'q'
            exit
          end
        end
      end
    end

    def local_options
      { project: project.project_name, filename: filename }
    end

    def template_path
      @template_path ||= project.template_path(template_file)
    end

    def read_from_template
      File.read(template_path)
    end

    def write_to_project(string)
      if File.exists?(absolute_path)
        current_contents = File.read(absolute_path)
        if current_contents == string
          Projenitor.reporter.report(:identical, absolute_path)
        else
          handle_exists(current_contents, string)
        end
      else
        Projenitor.reporter.report(:create, absolute_path)
        write(string)
      end
    end

    private

    def write(string)
      File.write(absolute_path, string)
    end

  end

end
