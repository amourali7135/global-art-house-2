class DropTag < ActiveRecord::Migration[6.0]
  def change
    drop_table :art_tags
    drop_table :artist_tags
    drop_table :tags
  end
end
