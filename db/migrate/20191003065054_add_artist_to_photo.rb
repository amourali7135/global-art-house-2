class AddArtistToPhoto < ActiveRecord::Migration[5.2]
  def change
      add_reference :artists, :photo, index: true
  end
end
