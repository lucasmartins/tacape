module Tacape
  module Os
    def initialize
      Tacape.logger.info 'OS compatibility layer NOT implemented!'
    end
  end

  class WrongOSException < StandardError
  end

  class OSLayerNotImplemented < StandardError
  end

end