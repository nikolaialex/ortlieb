require 'projekt1/version'
require 'hypermedia_parser'
require 'nokogiri'
require 'nokogiri/html/document'
require 'nokogiri/xml/node_set'
require 'micro_data_document'
require 'nokogiri/xml/node'

module Projekt1



  document1 = HypermediaParser.enter("http://localhost:8084/WebApplication3/")
  allObjects = document1.get_top_level_objects()

  puts allObjects[0].get_Propertys()
  puts allObjects[0].name
  puts allObjects[0].Actor
  puts "finished"

end