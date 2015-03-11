require "csv"

class SpotInformation
  class << self
    def export_csv
      CSV.open('./tmp_sopt_info.csv', 'w') do |csv|
        headers = ['name', 'furigana', 'alphabet', 'keywords', 'abroad', 'country', 'prefecture', 'area', 'latitude', 'longitude', 'tmp_name']
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
          spot = Spot.find_by_tmp_name(row[10])
          row.each_with_index do |record, i|
            case i
            when 0  then spot.update_attributes!(name: record)
            when 1  then spot.update_attributes!(furigana: record)
            when 2  then spot.update_attributes!(alphabet: record)
            when 3  then spot.update_attributes!(keywords: record)
            when 4  then spot.update_attributes!(abroad: record)
            when 5  then spot.update_attributes!(country: record)
            when 6  then spot.update_attributes!(prefecture: record)
            when 7  then spot.update_attributes!(area: record)
            when 8  then spot.update_attributes!(sea: record)
            when 9  then spot.update_attributes!(latitude: record)
            when 10 then spot.update_attributes!(longitude: record)
            when 11 then spot.update_attributes!(tmp_name: record)
            end
          end
        end
      end
    end
  end
end
