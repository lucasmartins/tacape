require 'active_support/all'
require 'digest/md5'
require 'erb'
require 'logger'
require 'notifier'
require 'tempfile'
require 'pathname'
require 'thor'
require 'thor/group'
require 'yaml'
require 'os'
require 'i18n'
require 'pry'
require 'pry-nav'

Encoding.default_internal = "utf-8"
Encoding.default_external = "utf-8"

#Adds a way to retrieve Submodules of a Module, used for CustomContentParsers
class Module
  def submodules
    constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
  end
end

module Tacape
  ROOT = Pathname.new(File.dirname(__FILE__) + "/..")

  autoload :Cli,      "tacape/cli"
  load "tacape/belt.rb"
  autoload :Version,  "tacape/version"

  def initialize(*args)
    super
    self.create_folder_structure
  end

  def self.config(root_dir = nil)
    root_dir ||= Pathname.new(Dir.pwd)
    path = root_dir.join("config/tacape.yml")

    raise "Invalid Tacape directory; couldn't found config/tacape.yml file." unless File.file?(path)
    content = File.read(path)
    erb = ERB.new(content).result
    YAML.load(erb).with_indifferent_access
  end

  def self.locale
    I18n.load_path = Dir['config/locales/*.yml']
    I18n.backend.load_translations
    
    @locale ||= Belt.current_os.locale
    case @locale
    when 'pt_BR'
      I18n.locale = :"pt-BR"
    else
      I18n.locale = :en
    end
    return @locale
  end
  Tacape.locale

  def self.logger
    @logger ||= Logger.new(File.open("/tmp/tacape.log", "a"))
  end

  def self.create_folder_structure
      unless File.exists? @config_folder
        FileUtils.mkdir_p("#{@config_folder}/tools")
        #FileUtils.mkdir_p("#{@config_folder}/plugins")
      end
    end
end
