#You must add -> load "tacape/tools/sample.rb" to cli.rb
module Tacape
  module Tools
    class Sample < Thor
      namespace 'sample'

      desc 'test','This is just a sample'
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