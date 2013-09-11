require 'erb'

# class Projenitor::Template

  class ErbRunner

    attr_reader :contents

    def initialize(contents, locals)
      @contents = contents
      
      meta = class << self
        self
      end

      locals.each do |var, value|
        meta.send(:define_method, var) { value }
      end
    end

    def execute
      erb = ERB.new(contents)
      erb.result(binding)
    end

  end

# end
