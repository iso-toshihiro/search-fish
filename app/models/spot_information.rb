require "csv"

class SpotInformation
  class << self
    def export_csv
      CSV.open('./tmp_sopt_info.csv', 'w') do |csv|
        headers = ['name', 'furigana', 'alphabet', 'keywords', 'abroad', 'country', 'prefecture', 'area', 'sea', 'latitude', 'longitude', 'tmp_name']
        csv << headers
        Spot.all.each do |spot|
          line = []
          line << spot.name
          line << spot.furigana
          line << spot.alphabet
          line << spot.keywords
          line << spot.abroad
          line << spot.country
          line << spot.prefecture
          line << spot.area
          line << spot.sea
          line << spot.latitude
          line << spot.longitude
          line << spot.tmp_name
          line << spot.id
          csv << line
        end
      end

      CSV.open('./only_sopt_info.csv', 'w') do |csv|
        spot_names = Spot.all.map { |spot| spot.tmp_name }
        csv << spot_names
      end
    end

    def import_csv(filepath)
      CSV.foreach(filepath).with_index do |row, line|
        next if line == 0
        Spot.transaction do
          spot = Spot.find_by_tmp_name(row[11])
          next if spot.nil?
          hash = {name: row[0], furigana: row[1], alphabet: row[2], keywords: row[3], abroad: row[4], country: row[5], prefecture: row[6], area: row[7], sea: row[8], latitude: row[9], longitude: row[10], tmp_name: row[11]}
          spot.update_attributes!(hash)
        end
      end
    end
  end
end
