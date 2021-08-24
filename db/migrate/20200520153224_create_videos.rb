class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos, id: :uuid do |t|
      t.text :description

      t.timestamps
    end
    add_column :videos, :clip, :string
  end
end
