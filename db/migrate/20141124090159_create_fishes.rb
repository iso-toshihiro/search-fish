class CreateFish < ActiveRecord::Migration
  def change
    create_table :fishes do |t|
      t.string :name

      t.timestamps
    end
  end
end
