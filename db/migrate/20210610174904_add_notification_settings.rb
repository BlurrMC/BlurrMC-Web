class AddNotificationSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :follownotifications, :boolean, default: true
    add_column :users, :commentnotifications, :boolean, default: true
    add_column :users, :likecommentnotification, :boolean, default: true
    add_column :users, :replynotifications, :boolean, default: true
    add_column :users, :likedvideonotifications, :boolean, default: true
  end
end
