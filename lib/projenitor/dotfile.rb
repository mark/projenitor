module Projenitor

  module Dotfile

    def self.build_dotfile_dir
      if File.exists?(dotfile_path)
        unless File.directory?(dotfile_path)
          puts "~/.projenitor must be a directory"
          exit
        end
      else
        Dir.mkdir(dotfile_path)
      end
    end

    def self.dotfile_path
      File.join(Dir.home, '.projenitor')
    end

    def self.template_path(path)
      basename = File.basename(path)
      File.join(dotfile_path, basename)
    end

    def self.template_manifest_path(path)
      basename = File.basename(path)
      File.join(dotfile_path, basename, "manifest.rb")
    end

    def self.template_file_path(template, file)
      File.join(dotfile_path, template, file)
    end

    def self.templates
      template_paths = Dir[ File.join(dotfile_path, '*') ]
      template_paths.map { |template_path| File.basename(template_path) }
    end

  end

end
