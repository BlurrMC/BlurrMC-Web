class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports, id: :uuid do |t|
      t.uuid :recipient_id
      t.uuid :actor_id
      t.datetime :reported_at
      t.uuid :reportable_id
      t.string :reportable_type

      t.timestamps
    end
    add_index :reports, :actor_id
    add_index :reports, [:actor_id, :reportable_id, :reportable_type], unique: true
  end
end
