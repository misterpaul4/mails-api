class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :content
      t.boolean :read
      t.integer :creator_id

      t.timestamps
    end
  end
end
