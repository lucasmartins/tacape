module Tacape
  class WrongOSException < StandardError
  end

  class OSLayerNotImplemented < StandardError
  end

  class UnsupportedOS < StandardError
  end
end