class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.string :name
      t.string :another_name
      t.string :group
      t.string :url
      t.string :url2

      t.timestamps
    end
  end
end
