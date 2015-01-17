require 'nokogiri'
require 'open-uri'
require 'URI'

class Fish < ActiveRecord::Base
  has_many :fish_spots
  has_many :spots, through: :fish_spots

  class << self
    def exist?(name)
      find_by_name(name).present?
    end

    def fetch_pic_url(fish_name, num)
      search_url = URI.encode("http://image.search.yahoo.co.jp/search?p=#{fish_name}")

      doc = Nokogiri.HTML(open(search_url))
      src_url = doc.xpath("//p[@class='tb']/a")[num].attribute('href').value

      return "excess bytesize" if src_url.bytesize > 255
      src_url
    end
  end
end
