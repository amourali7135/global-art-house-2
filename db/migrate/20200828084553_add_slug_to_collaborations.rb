class AddSlugToCollaborations < ActiveRecord::Migration[6.0]
  def change
    add_column :collaborations, :slug, :string
    add_index :collaborations, :slug, unique: true
  end
end
