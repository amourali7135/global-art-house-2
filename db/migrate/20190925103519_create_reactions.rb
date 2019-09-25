class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.references :art, foreign_key: true

      t.timestamps
    end
  end
end
