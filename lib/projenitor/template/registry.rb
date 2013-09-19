class Projenitor::Template

  class Registry

    ################
    #              #
    # Declarations #
    #              #
    ################

    Entry = Struct.new(:mapping, :options, :strict?)
    
    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize
      @mappings = {}
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################

    def build
      entries.each do |entry|
        reference = entry.mapping
        options   = entry.options

        reference.build(options)
      end
    end

    def dependency(mapping)
      e = entry(mapping)

      if e.nil?
        add_entry mapping, {}, false
      end
    end

    def register(mapping, options)
      e = entry(mapping)

      if e.nil?
        add_entry mapping, options, true
      elsif e.strict? && options != e.options
        puts "ERROR: Defining #{ mapping.absolute_path } with distinct options #{ options.inspect } and #{ e.options.inspect }"
        exit
      else
        e.options = options
        e.strict  = true
      end
    end

    private

    def add_entry(mapping, options, strict)
      e = Entry.new(mapping, options, strict)
      @mappings[ mapping.absolute_path ] = e
    end

    def entry(mapping)
      @mappings[ mapping.absolute_path ]
    end

    def entries
      @mappings.values.sort_by { |entry| entry.mapping.absolute_path }
    end

  end

end
