class DropTableTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :art_tags    
    drop_table :tags
  end
end
