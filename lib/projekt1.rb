require 'projekt1/version'
require 'hypermedia_parser'
require 'nokogiri'
require 'nokogiri/html/document'
require 'nokogiri/xml/node_set'
require 'micro_data_document'
require 'nokogiri/xml/node'

module Projekt1



 # document1 = HypermediaParser.enter("http://localhost:8084/WebApplication3/")
  document1 = HypermediaParser.enter("http://www.youtube.com/watch?v=YXiEGUJKNrQ")
  allObjects = document1.get_top_level_objects()

  puts allObjects[0].get_Propertys()
  puts allObjects[0].name
  puts allObjects[0].description
  puts allObjects[0].paid
  puts allObjects[0].author.size
  puts allObjects[0].author[0].get_Propertys()
  puts allObjects[0].author[0].url
  puts allObjects[0].author[1].url
  puts "finished"

end