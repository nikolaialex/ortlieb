require 'nokogiri'
require 'open-uri'
require 'nokogiri/html/document'
require 'nokogiri/xml/node'
require 'micro_data_object'



class MicroDataDocument

  attr_accessor :url, :html_doc

  def initialize(url)
    @url = url
    @html_doc = Nokogiri::HTML(open(url))
  end

  def get_top_level_objects()
    root = html_doc.root()
    topLevelObjects = self.get_Child_Nodes(root,Array.new())
    return topLevelObjects
  end

  def get_Child_Nodes(node, objectList)
    if node.attr("itemtype") != nil and node.attr("itemprop") == nil
      objectList.push(MicroDataObject.new(node, self))
      return objectList
    end
    for child in node.children() do
      objectList = self.get_Child_Nodes(child, objectList)
    end
    return objectList
  end

  def get_Links()
    fakeObject = MicroDataObject.new(@html_doc.root(), self)
    return fakeObject.get_Links()
  end

end