class RenameTaggings < ActiveRecord::Migration[5.2]
  def change
    rename_column :tags, :tagging, :art_tagging
  end
end
