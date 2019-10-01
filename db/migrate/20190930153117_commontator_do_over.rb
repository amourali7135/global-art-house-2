class CommontatorDoOver < ActiveRecord::Migration[5.2]
  def change
    drop_table :attachinary_files
    drop_table :commontator_comments
    drop_table :commontator_subscriptions
    drop_table :commontator_threads
  end
end
