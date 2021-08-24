json.comments @comments.is_parent.each do |comment|
    json.partial! comment, partial: 'comment', reply: false
end
json.video_id @commentable.id