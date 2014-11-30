class CreateFishSpots < ActiveRecord::Migration
  def change
    create_table :fish_spots do |t|
      t.integer :spot_id, :null => false
      t.integer :fish_id, :null => false
    end
  end
end
