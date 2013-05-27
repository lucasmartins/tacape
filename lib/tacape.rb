require "active_support/all"
require "digest/md5"
require "erb"
require "logger"
require "notifier"
require "tempfile"
require "pathname"
require "thor"
require "thor/group"
require "yaml"
require "os"
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
  autoload :Belt,     "tacape/belt"
  autoload :Version,  "tacape/version"
  #autoload :ToolSample, "tacape/tools/sample"

  def self.config(root_dir = nil)
    root_dir ||= Pathname.new(Dir.pwd)
    path = root_dir.join("config/tacape.yml")

    raise "Invalid Tacape directory; couldn't found config/tacape.yml file." unless File.file?(path)
    content = File.read(path)
    erb = ERB.new(content).result
    YAML.load(erb).with_indifferent_access
  end

  def self.logger
    @logger ||= Logger.new(File.open("/tmp/tacape.log", "a"))
  end
end
