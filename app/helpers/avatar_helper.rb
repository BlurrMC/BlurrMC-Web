module AvatarHelper 
    def user_avatar_variant(user, classes, variant = {})
        if user.avatar.attached?
            image_tag(user.avatar.variant(variant), class: classes)
        else
            if user.default_avatar != nil
                image_tag(user.default_avatar, class: classes)
            else
                user.default_avatar = "fallback/default-avatars/#{rand(1..9)}.png"
                if user.save
                    image_tag(user.default_avatar, class: classes)
                end
            end
        end
    end
    def user_avatar_url(user, variant = {})
        if user.avatar.attached?
            url_for(user.avatar.variant(variant))
        else
            if user.default_avatar != nil
                image_path(url_for(user.default_avatar))
            else
                user.default_avatar = "fallback/default-avatars/#{rand(1..9)}.png"
                if user.save
                    url_for(user.default_avatar)
                end
            end
        end
    end
end