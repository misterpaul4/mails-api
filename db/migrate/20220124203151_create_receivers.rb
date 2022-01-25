class CreateReceivers < ActiveRecord::Migration[6.1]
  def change
    create_table :receivers do |t|
      t.integer :received_message_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
