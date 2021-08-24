json.array! @notifications do |notification|
    json.id notification.id
    json.unread !notification.read_at?
    if !current_user.blocking?(notification.actor)
        json.template render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]
    end
end