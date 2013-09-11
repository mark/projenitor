require 'fileutils'

class LinkCommand

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :path, :link_path

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(path)
    @path      = File.expand_path(path)
    @link_path = Projenitor::Dotfile.template_path(path)
  end

  #################
  #               #
  # Class Methods #
  #               #
  #################
  
  def self.desc
    ["link PATH", "Links the directory at PATH as a new projenitor template"]
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
    dotfile_exists?
    valid_path?
    manifest_exists?

    clear_existing_link
    create_link_path
  end

  private

  def clear_existing_link
    if File.symlink?(link_path)
      puts "Deleting existing symlink to #{ File.realpath(link_path) }"
      FileUtils.remove_file(link_path)
    elsif File.exists?(link_path)
      puts "Can't link to #{ link_path }, already exists as a file or directory"
      exit
    end
  end

  def create_link_path
    FileUtils.symlink(path, link_path)
    puts "Linking #{ link_path } to #{ path }"
  end

  def dotfile_exists?
    Projenitor::Dotfile.build_dotfile_dir
  end

  def manifest_exists?
    unless File.exists?( File.join(path, "manifest.rb") )
      puts "No manifest.rb file found at #{ path }"
      exit
    end
  end

  def valid_path?
    unless File.directory?(path)
      puts "#{ path } is not a valid directory"
      exit
    end
  end

end
