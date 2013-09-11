class TemplateCommand < Thor

  #################
  #               #
  # Class Methods #
  #               #
  #################
  
  class << self

    attr_reader :template_name

    def create_command_class(template_name)
      Class.new(TemplateCommand) do
        @template_name = template_name

        #################
        #               #
        # Thor Commands #
        #               #
        #################
        
        desc *BuildCommand.desc(template_name)

        def build(path, *args)
          template = self.class.template_name
          BuildCommand.execute(template, path, args)
        end

      end

    end

    def namespace
      template_name
    end

  end

end
