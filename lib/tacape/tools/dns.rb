#coding: utf-8
require 'fiber'

module Tacape
  module Tools
    class Dns < Thor
      include Tacape::Tools::Helpers::JsonConfig
      namespace 'dns'

      CONFIG_FILE="#{Tacape::Belt.current_os.config_folder}/dns.json"
      C_MARK='✓'
      X_MARK='✘'
      
      def initialize(*args)
        super
        @config={
          'default_names_file'=>"#{ENV['HOME']}/names.txt",
          'default_output_file'=>"#{ENV['HOME']}/output.txt",
          'default_suffixes'=>['.com','.io']
        }
      end

      desc 'check_names','This is just a sample'
      def test
        load_config
        puts "Implement your tool like this, pay attention to the namespace so it doesn't clash with other tools."
      end

    end
  end

  #Redefining the Cli to use this Tool
  class Cli < Thor
    desc 'dns','Tacape Tool for DNS things'
    subcommand 'dns', Tools::Dns
  end
end