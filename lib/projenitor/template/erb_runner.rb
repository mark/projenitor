require 'erb'

module Projenitor::Template

  class ErbRunner

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :contents

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(contents, locals)
      @contents = contents

      define_local_methods(locals)      
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    FileHandler.register_file_handler '.erb', self

    def self.process(file_mapping, options)
      erb_template = file_mapping.read_from_template
      result       = new(erb_template, options).execute

      file_mapping.write_to_project(result)
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def execute
      erb = ERB.new(contents)
      erb.result(binding)
    end

    private

    def define_local_methods(locals)
      locals.each do |local, value|
        metaclass.send(:define_method, local) { value }
      end
    end

    def metaclass
      @metaclass ||= class << self; self; end
    end

  end

end
