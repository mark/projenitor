class BuildCommand

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :template, :path, :options

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(template, path, args)
    @template = template
    @path     = path
    @options  = DynamicOptionParser.parse(args)
  end

  #################
  #               #
  # Class Methods #
  #               #
  #################
  
  def self.desc(template_name)
    ["build PATH", "Build a new #{ template_name } project at PATH"]
  end

  def self.execute(*args)
    new(*args).run
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def run
    puts "Template = #{ template }"
    puts "Path     = #{ path     }"
    puts "Options  = #{ options.inspect }"

    klass   = Template.create_template_class(template)
    builder = klass.new(path, template, options)

    builder.setup!
    builder.build!
  end

end
