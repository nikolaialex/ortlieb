require 'nokogiri/xml/node'
require 'hypermedia_parser'
require 'micro_data_document'
require 'micro_data_object'
require 'nokogiri/html/document'
require 'rest_client'
require 'uri'



class Form

  def initialize(root, parent)
    @root = root
    @parent = parent
  end

  def to_s
    if @root.attr("data-rel") != nil
      rel = @root.attr("data-rel")
      "<form @>" + rel
    else
      "<form @>"
    end
  end


 def get_params()
   out = []
   for child in @root.children()
     if child.name() == 'input'
       if child.attr('type') != nil and child.attr('type') == 'hidden'
         next
       end
       if child.attr('name') != nil
         out.push(child.attr("name"))
       end
     end
   end
   return out
 end



  def submit(args)

    action = @root.attr("action")
    uri = URI.join(@parent.url, action)
    if @root.attr('method') == nil or @root.attr('method') == "GET" or @root.attr('method') == "get"
      response = RestClient.get(uri, args)
    elsif @root.attr('method') == "POST" or @root.attr('method') == 'post'
      response = RestClient.post(uri, args)
    end

    microDataDoc = MicroDataDocument.new('no')
    newDoc = Nokogiri::HTML(response)
    microDataDoc.html_doc = newDoc
    microDataDoc.url = uri
    return microDataDoc
  end

end