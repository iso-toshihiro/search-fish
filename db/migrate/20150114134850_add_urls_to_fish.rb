class AddUrlsToFish < ActiveRecord::Migration
  def change
    add_column :fish, :url, :string
    add_column :fish, :url2, :string
  end
end
