class AddPhotoToArt < ActiveRecord::Migration[6.0]
  def change
    add_column :arts, :photo, :string
  end
end
