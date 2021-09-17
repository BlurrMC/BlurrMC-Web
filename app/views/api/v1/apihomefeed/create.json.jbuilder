json.videos @videos.each do |video|
    if !video.user.blocking?(current_user)
        json.videourl video.clip.url
        json.videoid video.id
        if !Report.exists?(reportable_id: video, actor_id: current_user, reportable_type: "Video") && video.user != current_user
            json.reported false
        else
            json.reported true
        end
    elsif !current_user.blocking?(video.user)
        json.videourl video.clip.url
        json.videoid video.id
        if !Report.exists?(reportable_id: video, actor_id: current_user, reportable_type: "Video") && video.user != current_user
            json.reported false
        elsif video.user == current_user
            json.reported false
        else
            json.reported true
        end
    end
end