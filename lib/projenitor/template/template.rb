class Template

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :root_path, :template_name, :options

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(root_path, template_name, options)
    @root_path     = root_path
    @template_name = template_name
    @options       = options
  end

  #################
  #               #
  # Class Methods #
  #               #
  #################
  
  def self.create_template_class(template)
    manifest_file     = Dotfile.template_manifest_path(template)
    manifest_contents = File.read(manifest_file)

    klass = Class.new(self) do
      class_eval(<<-RUBY, manifest_file, 0)
        def build!
          #{ manifest_contents }
        end
      RUBY
    end
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def absolute_path(local_path)
    File.join(root_path, local_path)
  end

  def directory(local_path)
    target = absolute_path(local_path)
    
    ensure_directory(target)
  end

  def ensure_directory(absolute_dir)
    if File.directory?(absolute_dir)
      puts "EXISTS: #{ absolute_dir }"
    elsif File.exists?(absolute_dir)
      puts "ERROR: #{ absolute_dir } exists and is not a directory"
      exit
    else
      puts "CREATE: #{ absolute_dir }"
      FileUtils.makedirs(absolute_dir)
    end
  end

  def file(local_path, template_file, options = {}, &block)
    target   = absolute_path(local_path)
    template = template_path(template_file)

    ensure_directory File.dirname(target)

    puts "CREATE: #{ target }"

    if File.extname(template_file) == '.erb'
      locals = options.fetch(:locals) { Hash.new }
      contents = File.read(template)
      erb      = ErbRunner.new(contents, locals)
      result   = erb.execute
      
      File.write(target, result)
    else
      FileUtils.copy_file(template, target)
    end
  end

  def local_name
    File.basename(root_path)
  end

  def setup!
    ensure_directory(root_path)
  end

  def template_path(template_file)
    file = Dotfile.template_file_path(template_name, template_file)
  end

end
