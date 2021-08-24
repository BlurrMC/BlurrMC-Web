class AddUserIdToCs < ActiveRecord::Migration[6.0]
  def change
    add_reference :cs, :user, null: false, foreign_key: true, type: :uuid
  end
end
