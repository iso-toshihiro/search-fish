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
        p "fish_id:#{fish.id}"
        unless fish.url && fish.url2
          transaction do
            fish.url ||= fetch_pic_url(fish.name, 0)
            fish.url2 ||= fetch_pic_url(fish.name, 1)
            fish.save!
          end
          p "New URL fish_id:#{fish.id} name:#{fish.name}"
        end
      end
    rescue => e
      p e
    end

    private

    def fetch_pic_url(fish_name, num)
      search_url = URI.encode("http://image.search.yahoo.co.jp/search?p=#{fish_name}")

      doc = Nokogiri.HTML(open(search_url))
      src_url = doc.xpath("//p[@class='tb']/a")[num].attribute('href').value

      return "excess bytesize" if src_url.bytesize > 255
      src_url
    end
  end
end
