class CreateCollaborations < ActiveRecord::Migration[6.0]
  def change
    create_table :collaborations do |t|
      t.string :title
      t.text :description
      t.text :goal
      t.string :photo
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end

