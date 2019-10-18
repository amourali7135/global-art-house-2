class DropOldTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :attachinary_files
    drop_table :mailboxer_receipts
    drop_table :mailboxer_notifications
    drop_table :mailboxer_conversation_opt_outs
    drop_table :mailboxer_conversations

  end
end
