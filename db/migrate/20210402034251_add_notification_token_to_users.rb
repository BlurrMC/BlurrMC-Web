class AddNotificationTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :notification_token, :string
  end
end
