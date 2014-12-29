require 'projekt1/version'
require 'hypermedia_parser'
require 'nokogiri'
require 'nokogiri/html/document'
require 'nokogiri/xml/node_set'
require 'micro_data_document'
require 'nokogiri/xml/node'


module Projekt1




 # document1 = HypermediaParser.enter("http://www.youtube.com/watch?v=YXiEGUJKNrQ")
  #allObjects = document1.get_top_level_objects()
=begin
  puts allObjects[0].get_Propertys()
  puts allObjects[0].name
  puts allObjects[0].description
  puts allObjects[0].paid
  puts allObjects[0].author.size
  puts allObjects[0].author[0].get_Propertys()
  puts allObjects[0].author[0].url
  puts allObjects[0].author[1].url}
  puts "finished"
  objects = document1.get_top_level_objects()
  puts document1.class
  puts document1.get_Links().size()
  links = document1.get_Links()
  puts links[0][0].get_Url()
  puts links[1][0].get_Url()

=end

  document1 = HypermediaParser.enter("http://localhost:8084/WebApplication4/")
  links = document1.get_Links()
  document2 = links['allCars'][0].follow()
  object1 = document2.get_top_level_objects()[0]
  p object1.get_Propertys()
  p object1.offers.get_Propertys()
  p object1.offers.price

  #document3 = form1.submit({:customer => 'Musterfrau',:paymentdue => "2014-10-14", :orderedItem => 'Golf'})

  p "finished"

#document2 = forms['orphan'][0].submit({:q => 'hypermedia'})
end