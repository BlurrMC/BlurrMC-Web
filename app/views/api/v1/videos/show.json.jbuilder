json.thumbnail_url @video.clip.thumb.url
json.video_url @video.clip.url
json.call @video, :description
json.call @video.user, :username
json.likecount @video.likes.count
json.publishdate @video.created_at.strftime("%B #{@video.created_at.day.ordinalize}, %Y")
json.viewcount @video.impressionist_count(:filter=>:ip_address) 
json.nextvideoid @video.next.id if @video.next
json.previousvideoid @video.prev.id if @video.prev
if user_signed_in?
    if !Report.exists?(reportable_id: @video, actor_id: current_user, reportable_type: "Video") && @user != current_user
        json.reported false
    else
        json.reported true
    end
    if @video.user == current_user
        json.videoisowned true
    else
        json.videoisowned false
    end
else
    json.videoisowned false
    json.reported false
end