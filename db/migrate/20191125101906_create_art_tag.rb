class CreateArtTag < ActiveRecord::Migration[5.2]
  def change
    create_table :art_tags do |t|
      t.references :art, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
