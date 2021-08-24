class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks, id: :uuid do |t|
      t.uuid :blocker_id
      t.uuid :blocked_id

      t.timestamps
    end

    add_index :blocks, :blocker_id
    add_index :blocks, :blocked_id
    add_index :blocks, [:blocker_id, :blocked_id], unique: true
  end
end
