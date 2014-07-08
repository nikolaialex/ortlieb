require 'micro_data_document'

class HypermediaParser

  def self.enter(url)
      return MicroDataDocument.new(url)
  end

end