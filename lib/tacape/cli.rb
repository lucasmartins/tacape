# -*- encoding: utf-8 -*-
module Tacape
  class Cli < Thor
    autoload :Sample, "tools/sample"

    def self.exit_on_failure?
      true
    end

    desc "version", "Shows version"
    map %w(-v --version) => :version
    def version
      say "Tacape version #{Version::STRING}"
    end

    desc "sample", "Sample test"
    def test
      subcommand "test", Sample
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
