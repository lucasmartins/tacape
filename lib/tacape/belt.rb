module Tacape
  load "tacape/oses/osx.rb"
  load "tacape/oses/fedora.rb"
  load "tacape/oses/os_exceptions.rb"

  class Belt
    def self.os_families
      #msoft: [windows: Windows]
      {:mac=> {:osx=>Tacape::Os::Osx}, :linux=> {:fedora=>Tacape::Os::Fedora}}
    end

    #Returns the current OS class
    def self.current_os
      current_os=:unknown
      current_os=self.os_families[:mac][:osx] if OS.osx?
      current_os=self.os_families[:msoft][:windows] if OS.windows?
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