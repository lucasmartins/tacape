module Tacape
  module Tools
    module Helpers
      module OsSupport
        module InstanceMethods
          def check_os_support
            raise(OSLayerNotImplemented,'tool should have @os_support=[Tacepe::Os::SomeOs,...]') if @os_support==nil
            @current_os=Tacape::Belt.current_os if @current_os==nil
            unless @os_support.include? @current_os
              raise UnsupportedOS, "This Tacape Tool does not support your OS."
            end
          end
          
        end
        
        def self.included(receiver)
          receiver.send :include, InstanceMethods
        end

      end
    end
  end
end