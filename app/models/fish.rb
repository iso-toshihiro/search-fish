require 'URI'

class Fish < ActiveRecord::Base
  has_many :fish_spots
  has_many :spots, through: :fish_spots

  class << self
    def exist?(name)
      find_by_name(name).present?
    end

    def save_fish_picture_url
      all.each do |fish|
        unless fish.url && fish.url2
          search_word = fish.search_word.nil? ? fish.name : fish.search_word
          urls = fetch_pic_urls(search_word)
          transaction do
            fish.url ||= urls[0]
            fish.url2 ||= urls[1]
            fish.save!
          end
          p "New URL fish_id:#{fish.id} name:#{fish.name}"
        end
      end
    rescue => e
      p e
    end

    private

    def fetch_pic_urls(search_word)
      search_url = URI.encode("http://image.search.yahoo.co.jp/search?p=#{search_word}")
      doc = Nokogiri.HTML(open(search_url))

      2.times.map.with_index do |i|
        url = doc.xpath("//p[@class='tb']/a")[i].attribute('href').value
        url.bytesize > 255 ? 'excess bytesize' : url
      end
    end
  end
end
