# -*- encoding: utf-8 -*-
module Tacape
  load "tacape/tools/helpers/json_config.rb"
  #load "tacape/tools/helpers/os_support.rb"
  load "tacape/tools/dns.rb"
  load "tacape/tools/gitrepo.rb"
  
  class Cli < Thor
    
    def initialize(*args)
      super
      puts I18n.t('greeting')
    end

    def self.exit_on_failure?
      true
    end

    desc "version", "Shows version"
    map %w(-v --version) => :version
    def version
      say "Tacape version #{Version::STRING}"
    end

    desc "check", "Checks for system dependencies"
    map %w(-c --check) => :check
    def check
      if `which ffmpeg`.include? 'ffmpeg'
        ffmpeg=''
      end
      say "FFMPEG #{ffmpeg}"
    end

    private    
    def config
      YAML.load_file(config_path).with_indifferent_access
    end

    def config_path
      root_dir.join("config/tacape.yml")
    end

    def root_dir
      @root ||= Pathname.new(Dir.pwd)
    end

    def color(text, color)
      color? ? shell.set_color(text, color) : text
    end

    def color?
      shell.instance_of?(Thor::Shell::Color)
    end
  end
end
