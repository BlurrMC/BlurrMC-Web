class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
