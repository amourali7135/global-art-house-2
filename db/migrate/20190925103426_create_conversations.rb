class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :sender
      t.references :recipient
      add_foreign_key :conversations, :users, column: :sender_id, primary_key: :id
      add_foreign_key :conversations, :users, column: :recipient_id, primary_key: :id
      t.timestamps
    end
  end
end
