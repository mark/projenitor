class Projenitor::Template

  class FileHandler

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.register_file_handler(extension, klass)
      @file_handlers ||= Hash.new
      @file_handlers[extension] = klass
    end

    def self.[](extension)
      @file_handlers ||= Hash.new
      @file_handlers.fetch(extension) { Projenitor::Template::FileHandler }
    end

    def self.process(file_mapping, options)
      file_mapping.write_to_project( file_mapping.read_from_template )
    end

  end

end

