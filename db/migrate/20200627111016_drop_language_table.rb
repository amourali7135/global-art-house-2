class DropLanguageTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :languages
  end
end
