require 'nokogiri'
require 'open-uri'
require 'URI'

class FishPicture

  def self.url(fish_name)
#    search_url = "https://www.google.co.jp/search?q=#{fish_name}&source=lnms&tbm=isch"
    search_url = URI.encode("http://image.search.yahoo.co.jp/search?p=#{fish_name}")

    doc = Nokogiri.HTML(open(search_url))
    src_url = doc.xpath("//p[@class='tb']/a")[0].attribute('href').value
    src_url2 = doc.xpath("//p[@class='tb']/a/img")[0].attribute('src').value

    src_url
  end  
end
