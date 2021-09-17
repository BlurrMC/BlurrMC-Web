json.videos @videos.each do |video|
    json.videourl video.clip.url
    json.videoid video.id
    if user_signed_in?
        if !Report.exists?(reportable_id: video, actor_id: current_user, reportable_type: "Video") && video.user != current_user
            json.reported false
        elsif video.user == current_user
            json.reported false
        else
            json.reported true
        end
    else
        json.reported false
    end
end