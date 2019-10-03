class AddArtistToPhotoTwo < ActiveRecord::Migration[5.2]
  def change
    add_reference :photos, :artist, index: true
  end
end
