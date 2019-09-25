class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.string :artist_name
      t.string :photo
      t.text :bio
      t.integer :age
      t.string :birth_place
      t.string :instagram
      t.string :facebook
      t.string :website
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
