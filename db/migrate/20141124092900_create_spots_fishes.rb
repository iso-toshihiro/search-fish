class CreateSpotsFishes < ActiveRecord::Migration
  def change
    create_table :spots_fishes do |t|
      t.integer :spot_id, :null => false
      t.integer :fish_id, :null => false
    end
  end
end
