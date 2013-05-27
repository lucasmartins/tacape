module Tacape
  module Os
    class Fedora
      def initialize
        Tacape.logger.info 'Building OS class...'
        @version = Tacape::Fedora.version
        @config_folder = Tacape::Fedora.config_folder
      end

      def self.config_folder
        return "#{ENV['HOME']}/.config/tacape"
      end

      def self.identify
        if issue_info.include? 'Fedora'
          return Tacape::Belt.os_families[:linux][:fedora]
        else
          return nil
        end
      end

      def self.version
        if issue_info.include? 'Fedora'
          return issue_info.split(' ')[2]
        else
          raise WrongOSException,'Expecting Fedora'
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