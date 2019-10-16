class RemoveReactionShit < ActiveRecord::Migration[5.2]
  def change
    drop_table :reaction_types
    drop_table :reactions
  end
end
