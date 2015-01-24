# coding: utf-8
require 'nokogiri'
require 'open-uri'

class UpdatingFishInfo
  HOME_URL = 'http://www.padi.co.jp/'

  class << self
    def execute
      p "UpdatingFishInfo.execute START #{Time.now}"
      scrape_site
      Fish.save_fish_picture_url
      p "UpdatingFishInfo.execute END #{Time.now}"
    end

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
      return if fish[:name] =~ /の一種/ || fish[:name] =~ /の仲間/
      fish[:another_name] = fish_name_node.text[/(?<=\()#{japanese_regex}(?=\))/]

      unless Fish.exist?(fish[:name])
        Fish.transaction do
          @fish = Fish.create(fish)
        end
        p "New fish  id:#{@fish.id}, name:#{@fish.name}"
      end

      doc.xpath('//div[@class="list_img"]').each do |node|
        arr = node.children
        spot = arr[6].text == '(' ? arr[10].text : arr[6].text

        Spot.create(name: spot) unless Spot.exist?(spot)

        FishSpot.save_relation(fish[:name], spot)
      end
    rescue => e
      p e
    end
  end
end
