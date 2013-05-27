module Tacape
  module Tools
    module Helpers
      module JsonConfig
        module InstanceMethods
          def setup
            @config.each do |k,v|
              input = ask "#{k} [default=#{@config[k]}]:"
              unless input.empty?
                @config[k]=input
              end
              if k.include? 'folder'
                `mkdir -p #{@config[k]}`    
              end
            end

            @config['targets']=[{'name'=>'Rubies','address'=>'192.168.2.202'}]

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
          receiver.send :include, InstanceMethods
        end
      end
    end
  end
end