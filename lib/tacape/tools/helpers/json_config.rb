module Tacape
  module Tools
    module JsonConfig
      module InstanceMethods
        def setup
          input = ask "target_folder [default=#{@config['target_folder']}]:"
          unless input.empty?
            @config['target_folder']=input
          end

          input = ask "default preset [default=#{@config['preset']}]:"
          
          unless input.empty?
            @config['preset']=input
          end

          `mkdir -p #{@config['target_folder']}`

          save_config
        end

        def load_config
          if File.exist? CONFIG_FILE
            @config = JSON.parse(File.read(CONFIG_FILE))
            unless @config.class==Hash
              raise 'Corrupt JSON file!'
            end
            return
          else
            setup
          end
        end

        def save_config
          File.open(CONFIG_FILE, 'w') {|f| f.write(@config.to_json) }
        end
      end
      
      def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.send :include, InstanceMethods
      end
    end
  end
end