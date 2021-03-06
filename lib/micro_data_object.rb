require 'nokogiri/xml/node'
require 'nokogiri/xml'
require 'link'
require 'form'

class MicroDataObject

  attr_accessor :parent

  def initialize(root, parent)
    @root = root
    @parent = parent
  end


  def to_s
    t = @root.attr('itemtype')
    if t == nil
      return '<untyped>'
    else
      return '<Microdata Object @ ' + t + '>'
    end
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

  def get_Property(propertyName)
    propMap = get_PropMap()

    #todo if prop not in @propMap

    propArr = propMap[propertyName]
    if propArr != nil
      if propArr.size  == 1
        if propArr[0].attr('itemscope') == nil
          if propArr[0].attr('content') == nil and propArr[0].attr('href') == nil and propArr[0].attr('datetime') == nil
            property = propArr[0].content()
          elsif propArr[0].attr('href') != nil
            href = propArr[0].get_attribute('href')
            document1 = HypermediaParser.enter(href)
            object1 = document1.get_top_level_objects[0]
            property = object1
          elsif propArr[0].attr('datetime') != nil
            property = propArr[0].get_attribute('datetime')
          else
            property = propArr[0].attr('content')
          end

        elsif propArr[0].attr('itemscope') != nil
          property = MicroDataObject.new(propArr[0],@root)
        end

      elsif propArr.size > 1
        property = []
        i = 0
        for item in propArr
          if propArr[i].attr('itemscope') == nil
            if propArr[i].attr('content') == nil and propArr[i].attr('href') == nil and propArr[i].attr('datetime') == nil
              property.push propArr[i].content()
            elsif propArr[i].attr('href') != nil
              property.push propArr[i].[]("href")
            elsif propArr[i].attr('datetime') != nil
              property.push propArr[i].[]('datetime')
            else
              property.push propArr[0].attr('content')
            end
          elsif propArr[i].attr('itemscope') != nil
            property.push MicroDataObject.new(propArr[i], @root)
          end
          i = i +1
        end
      else return nil
      end
    end
    return property
  end

  def build_Link_Map_Helper(node)
    if (node.name() == "a" and node.attr("rel") != nil) or (node.name() =="link" and node.attr("rel") != nil)
      rel = node.attr("rel")
      if @linkMap[rel] == nil
        @linkMap[rel] = []
      end
      @linkMap[rel].push(Link.new(node, @parent))
      if node.attr("itemscope") != nil
        return
      end
    end
    for child in node.children()
      build_Link_Map_Helper(child)
    end
  end

  def build_Link_Map()
    @linkMap = Hash.new()
    for child in @root.children()
      build_Link_Map_Helper(child)
    end
  end


  def get_Link_Map()
    if @linkMap == nil then
      build_Link_Map()
    end
    return @linkMap
  end


  def get_Links()
    linkMap = get_Link_Map()
    return linkMap
  end

  def method_missing(m, *args, &block)
    if @propMap == nil
      build_Prop_Map
    end
    m = m.to_s
    if @propMap[m] != nil
      return get_Property(m)
    else
      puts "There's no method called #{m} here -- please try again."
    end
  end


  def get_Forms()
    formMap = get_formMap()
    return formMap
  end

  def get_formMap()
    if @formMap == nil then
      build_formMap()
    end
    return @formMap
  end

  def build_formMap()
    @formMap = Hash.new()
    for child in @root.children()
      build_formMap_Helper(child)
    end
  end

  def build_formMap_Helper(node)
    if node.name() == "form"
      rel = node.attr("data-rel")
      if rel == nil
        rel = 'orphan'
      end
      if @formMap[rel] == nil
        @formMap[rel] = []
      end
      @formMap[rel].push(Form.new(node, @parent))
      if node.attr("itemscope") != nil
        return
      end
    end
    for child in node.children()
      build_formMap_Helper(child)
    end
  end

  end
