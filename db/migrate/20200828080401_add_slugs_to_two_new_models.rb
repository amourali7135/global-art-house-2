class AddSlugsToTwoNewModels < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :slug, :string
    add_index :services, :slug, unique: true
    add_column :articles, :slug, :string
    add_index :articles, :slug, unique: true
  end
end
