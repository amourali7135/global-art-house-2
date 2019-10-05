class AddFormsToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :form, :string
  end
end
