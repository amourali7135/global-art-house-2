class AddStateToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :state, :string
  end
end
