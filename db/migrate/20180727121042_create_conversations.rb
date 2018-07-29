class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, foreign_key: true
      t.integer :recipient_id, foreign_key: true
      t.timestamps
    end
  end
end
