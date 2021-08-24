class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :body
      t.boolean :edited, default: false
      t.references :commentable, polymorphic: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.uuid :parent_id, foreign_key: true

      t.timestamps
    end

    create_table :commentlikes do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :comment, null: false, foreign_key: true, type: :uuid
    end
  end
end
