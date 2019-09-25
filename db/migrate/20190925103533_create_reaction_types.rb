class CreateReactionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :reaction_types do |t|
      t.string :reaction_kind
      t.references :reaction, foreign_key: true

      t.timestamps
    end
  end
end
