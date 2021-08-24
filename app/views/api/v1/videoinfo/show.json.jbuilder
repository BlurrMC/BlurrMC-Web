json.thumbnail_url @video.clip.thumb.url
json.call @video, :description
json.call @video.user, :username
json.likecount @video.likes.count
json.publishdate @video.created_at.strftime("%B #{@video.created_at.day.ordinalize}, %Y")
json.viewcount @video.impressionist_count(:filter=>:ip_address)