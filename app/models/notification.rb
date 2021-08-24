class Notification < ApplicationRecord
    validates :notifiable_id, uniqueness: {scope: [:recipient_id, :actor_id, :action, :notifiable_type], case_sensitive: false}
    after_commit :send_post_notification, on: :create

    belongs_to :recipient, class_name: "User"
    belongs_to :actor, class_name: "User"
    belongs_to :notifiable, polymorphic: true

    scope :unread, ->{ where(read_at: nil) }
    scope :recent, ->{ order(created_at: :desc).limit(5) }

    def send_post_notification
        if recipient.notification_token != ""
        if recipient.notification_token != nil
            n = Rpush::Apnsp8::Notification.new
            n.app = Rpush::Apnsp8::App.find_by_name("blurrmc")
            n.device_token = recipient.notification_token
            n.content_available = 1
            notifications = Notification.where(recipient: recipient).unread
            n.badge = notifications.count
            n.sound = "default"
            case action
            when "Commented"
                n.alert = "@#{self.actor.username} commented on your video."
            when "Liked comment"
                n.alert = "@#{self.actor.username} liked your comment."
            when "Replied"
                n.alert = "@#{self.actor.username} replied to your comment."
            when "followed"
                n.alert = "@#{self.actor.username} followed you!"
            when "liked"
                n.alert = "@#{self.actor.username} liked your video."
            else
                n.alert = "You have a new notification."
            end
            n.save!
        end
        end
    end
end
