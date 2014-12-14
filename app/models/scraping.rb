# coding: utf-8
require 'nokogiri'
require 'open-uri'

class Scraping
  HOME_URL = 'http://www.padi.co.jp/'

  class << self
    def scrape_site
      doc = Nokogiri::HTML(open(HOME_URL + '/pb/index.asp'))
    
      doc.xpath('//div[@class="category"]/div/a').each do |node|
        next if node.text =~ /TOP/
        
        access_fish_type_page(HOME_URL + node.attribute('href').value)
      end
    end

    private
  
    def access_fish_type_page(url)
      doc = Nokogiri::HTML(open(url))

      doc.xpath('//div[@class="list"]/a').each do |node|
        fish_url = HOME_URL + node.attribute('href').value
        extract_fish_info(Nokogiri::HTML(open(fish_url)))
      end
    end

    def extract_fish_info(doc)
      japanese_regex = /(\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+/

      fish_name_node = doc.css('ul.fishnm')
      fish = {}
      fish[:name] = fish_name_node.text[japanese_regex]
      fish[:another_name] = fish_name_node.text[/(?<=\()#{japanese_regex}(?=\))/]

      Fish.create(fish) unless Fish.exist?(fish[:name])

      doc.xpath('//div[@class="list_img"]').each do |node|
        arr = node.children
        spot = arr[6].text == '(' ? arr[10].text : arr[6].text

        Spot.create(name: spot) unless Spot.exist?(spot)

        FishSpot.save_relation(fish[:name], spot)
      end
    end
  end
end
