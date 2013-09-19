module Projenitor

  class Template

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :name, :root

    COMMANDS_FILENAME = "commands.rb"

    CONFIG_FILENAME   = "config.yml.erb"

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(name, root)
      @name = name
      @root = root
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def config_file

    end

    def commands_file
      return @commands_file if defined?(@commands_file)
       
      if File.exists?(commands_file_path)
        @commands_file = File.read(commands_file_path)
      else
        @commands_file = nil
      end
    end

    private

    def commands_file_path
      File.join(root, COMMANDS_FILENAME)
    end

  end

end
