json.notifications @notifications.each do |notification|
    json.notificationid notification.id
    json.unread !notification.read_at?
    json.action notification.action
    if !notification.actor.blocking?(current_user)
        json.template render partial: "api/v1/notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}
    end
        
end
json.notificationcount @notifications.count