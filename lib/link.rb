require 'nokogiri/xml/node'
require 'hypermedia_parser'
require 'micro_data_document'
require 'micro_data_object'
require 'nokogiri/html/document'
require 'uri'


class Link

  def initialize(root, parent)
    @root = root
    @parent = parent
  end

  def get_Url()

    href = @root.attr("href")

    return URI.join(@parent.url, href)
  end


  def follow()
    href = get_Url()
    return HypermediaParser.enter(href)
  end

  def to_s
    "<link @>" + @root.attr("href")
  end

  #def follow(self):
  #    href = self._elt.attrib['href']
  #resolved = urlparse.urljoin(self._doc._url, href)
  #up = urlparse.urlparse(resolved)
  #resolved_base = urlparse.urlunparse((up.scheme, up.netloc, up.path,
  #    up.params, up.query, ''))
  #if resolved_base == self._doc._url:
  #    # local
  #    return _value_of(self._doc, up.fragment)
  #else:
  #    # remote
  #    remote_doc = enter(resolved_base)
  #return _value_of(remote_doc, up.fragment)


end