class AddAnotherNameToFish < ActiveRecord::Migration
  def change
    add_column :fish, :another_name, :string
  end
end
