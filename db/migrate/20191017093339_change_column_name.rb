class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :conversations, :sender_id, :author_id
    rename_column :conversations, :recipient_id, :receiver_id
  end
end
