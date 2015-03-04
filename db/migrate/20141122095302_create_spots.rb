class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string  :name
      t.string  :furigana
      t.string  :alphabet
      t.string  :keywords
      t.boolean :abroad
      t.string  :country
      t.string  :prefecture
      t.string  :area
      t.float   :latitude
      t.float   :longitude
      t.string  :tmp_name
      
      t.timestamps
    end
  end
end
