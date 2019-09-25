class CreateArtTags < ActiveRecord::Migration[5.2]
  def change
    create_table :art_tags do |t|
      t.references :art, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
