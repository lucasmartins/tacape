# -*- encoding: utf-8 -*-
module Tacape
  load "tacape/tools/helpers/json_config.rb"
  load "tacape/tools/helpers/os_support.rb"
  
  class Cli < Thor
    Dir["#{Tacape::Belt.current_os.tool_folder}/**/*.rb"].each do |tool|
      load tool
    end
  
    def initialize(*args)
      super
      @current_os=Tacape::Belt.current_os
      create_folder_structure
      
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

    desc "update", "Updates the Tools local repository"
    map %w(-u --update) => :update
    def update
      update_tools
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

    def update_tools
      #Thread.new {
      puts 'Updating Tools repository...'
      `cd #{@current_os.tool_folder} && git pull`
      puts 'Installing Tools dependencies...'
      `cd #{@current_os.tool_folder} && bundle install`
      #}
    end

    def create_folder_structure
      unless File.exists? @current_os.config_folder
        FileUtils.mkdir_p(@current_os.config_folder)
      end
      unless File.exists? @current_os.tool_folder
        puts 'Cloning Tools repository...'
        `git clone git@github.com:lucasmartins/tacape-tools.git #{@current_os.tool_folder}`
        puts 'Installing Tools dependencies...'
        `cd #{@current_os.tool_folder} && bundle install`
      end
    end

  end
end
