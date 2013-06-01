module Tacape
  module Tools
    module Helpers
      module JsonConfig
        module InstanceMethods
          def setup
            @config={}
            @config_template.each do |k,v|
              tip=' use comma, no spaces' if v.class==Array
              if @config_template[k]!=nil && @config_template[k]!=''
                question = "#{k} [default=#{@config_template[k]}]#{tip}:"
              else
                question = "#{k}#{tip}:"
              end

              input = ask(question)

              unless input.empty?
                case v
                when String
                  @config[k]=input
                when Array
                  @config[k]=input.split(',')
                else
                  puts "Bailed on #{v.class}"
                end
                if k.include?('folder') || k.include?('file')
                  if File.dirname(@config[k]) == '.'
                    @config[k]="#{ENV['HOME']}/#{@config[k]}"  
                  end
                  unless File.exist?(File.dirname(@config[k]))
                    FileUtils.mkdir_p(File.dirname(@config[k]))  
                  end
                end
              else
                @config[k]=@config_template[k]  
              end
            end

            save_config
          end

          def load_config
            if File.exist? @config_file
              @config = JSON.parse(File.read(@config_file))
              unless @config.class==Hash
                raise 'Corrupt JSON file!'
              end
              return
            else
              setup
            end
          end

          def save_config
            unless File.exist? File.dirname(@config_file)
              FileUtils.mkdir_p(File.dirname(@config_file))
            end
            
            File.open(@config_file, 'w') {|f| f.write(@config.to_json) }
          end
        end
        
        def self.included(receiver)
          receiver.send :include, InstanceMethods
        end
      end
    end
  end
end