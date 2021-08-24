json.videos @videos.each do |video|
    json.videourl video.clip.url
    json.videoid video.id
end