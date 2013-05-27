module Tacape
  class Cli
    Tacape::logger.info 'Adding tool to Tacape::Cli'
    class Sample < Thor
      namespace 'sample'

      desc 'test','This is just a sample'
      def test
        puts "Implement your tool like this, pay attention to the namespace so it doesn't clash with other tools."
      end

    end
  end
end