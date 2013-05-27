module Tacape
  module Os
    class Osx
      def initialize
        Tacape.logger.info 'Building OS class...'
        @version = Tacape::Fedora.version
        @config_folder = Tacape::Fedora.config_folder
      end

      def self.config_folder
        return '~/.config/tacape'
      end

      def self.identify
        if OS.osx?
          return Tacape::Belt.os_families[:mac][:osx]
        else
          return nil
        end
      end

      def self.version
        if OS.osx?
          return `sw_vers -productVersion`.chomp
        else
          raise WrongOSException,'Expecting OSX'
        end
      end

      protected
        def issue_info
          id_file='/etc/issue'
          if File.exists?(id_file)
            return File.read(id_file)
          end  
        end

    end
  end
end