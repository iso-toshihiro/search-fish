class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name
      t.string :prefecture
      
      t.timestamps
    end
  end
end
