module VideosHelper
    def mentioned_channels(body) 
        body.gsub /@([\w]+)/ do |mention|
            if mention[0] == '@'
                user = mention
                user[0] = ''
                link_to mention, c_path(id: user) if User.friendly.exists?(user)
            elsif mention[0] == '#'
                link_to 'scam', c_path(search: mention)
            elsif mention[0] == '@'
                link_to 'scam', c_path(search: mention)
            end
        end.html_safe
    end
    
end
