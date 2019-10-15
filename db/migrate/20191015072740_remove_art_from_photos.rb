class RemoveArtFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_column :photos, :art
    remove_column :arts, :photo
  end
end
