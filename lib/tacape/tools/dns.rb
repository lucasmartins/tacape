require 'fiber'

module Tacape
  module Tools
    class Dns < Thor
      include JsonConfig
      namespace 'dns'

      desc 'check_names','This is just a sample'
      def test
        puts "Implement your tool like this, pay attention to the namespace so it doesn't clash with other tools."
      end

    end
  end

  #Redefining the Cli to use this Tool
  class Cli < Thor
    desc 'sample','Defines a Tacape tool'
    subcommand 'sample', Tools::Sample
  end
end