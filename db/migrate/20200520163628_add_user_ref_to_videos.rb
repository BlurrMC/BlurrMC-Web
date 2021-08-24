class AddUserRefToVideos < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :user, null: false, foreign_key: true, type: :uuid
  end
end
