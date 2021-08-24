json.videos @videos.each do |video|
    if !video.user.blocking?(current_user)
        json.videourl video.clip.url
        json.videoid video.id
    elsif !current_user.blocking?(video.user)
        json.videourl video.clip.url
        json.videoid video.id
    end
end