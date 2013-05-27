module Tacape
  autoload :Os, "oses/os"
  autoload :Osx, "oses/osx"
  autoload :Fedora, "oses/fedora"

  class Belt
    def self.os_families
      #msoft: [windows: Windows]
      {mac: [osx: Osx], linux: [fedora: Fedora]}
    end

    def self.current_os
      get_current_os_class
    end

    private
    def get_current_os_class
      current_os=:unknown
      current_os=Tacape::Belt.os_families[:mac][:osx] if OS.osx?
      current_os=Tacape::Belt.os_families[:msoft][:windows] if OS.windows?
      if OS.linux?
        Belt.os_families[:linux].each do |k,v|
          current_os=v.identify if v.identify!=nil
        end
      end
      if current_os==nil
        raise OSLayerNotImplemented, "Sorry, no goodies for you for now, we only support there OSes:\n#{Tacape::Belt.os_families}"
      else
        return current_os
      end
    end

  end
end