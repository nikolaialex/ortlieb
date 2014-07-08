require 'nokogiri/xml/node'
require 'nokogiri/xml'

class MicroDataObject

  attr_accessor :property

  def initialize(root, parent)
    @root = root
    @parent = parent
  end

  def get_Propertys
    if @propMap == nil
      build_Prop_Map()
    end
    for property in @propMap.keys
      instance_variable_set("@#{property}",@propMap[property])
    end
    return @propMap.keys
  end

  def build_Prop_Map
    if @propMap == nil
      @propMap = Hash.new
    end
    for child in @root.children()
      build_Prop_Map_Helper(child)
    end
  end

  def build_Prop_Map_Helper(node)
      if node.attr('itemprop') != nil
        prop = node.attr('itemprop')
        if @propMap[prop] == nil
          @propMap[prop] = []
        end
        propMapItem = @propMap[prop]
        propMapItem.push(node)
        if node.attr('itemscope') != nil
          return
        end
      end
      for child in node.children()
        build_Prop_Map_Helper(child)
      end
  end

  def get_PropMap()
    if @propMap == nil
      build_Prop_Map
    end
    return @propMap
  end

  def getProperty(propertyName)
    propMap = get_PropMap()


    #todo if prop not in @propMap

    proArr = propMap[propertyName]


  end

  def method_missing(m, *args, &block)
    if @propMap == nil
      build_Prop_Map
    end
    m = m.to_s
    if @propMap[m] != nil
      return getProperty(m)
    else
      puts "There's no method called #{m} here -- please try again."
    end
  end
end
