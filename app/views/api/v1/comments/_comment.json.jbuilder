json.id comment.id
json.body comment.body
json.created_by comment.user.username
json.time_since_creation distance_of_time_in_words(comment.created_at, Time.now)
json.likes comment.commentlikes.count
json.reply reply
json.edited comment.edited
if comment.user == current_user
    json.comment_is_editable true
else
    json.comment_is_editable false
end
if !Report.exists?(reportable_id: comment, actor_id: current_user, reportable_type: "Comment") && comment.user != current_user
    json.reported false
else
    json.reported true # This will always return true if the user is themselves
end
if reply == true
    json.parent_id parent.id
else
    json.parent_id comment.id
end
pre_like = comment.commentlikes.find { |commentlike| commentlike.user_id == current_user.id}
if pre_like
    json.liked true
    json.likeId comment.commentlikes.find_by(user_id: current_user.id).id
else
    json.liked false
    json.likeId "0"
end
if reply != true
    if comment.replies.any?
        json.replies comment.replies.each do |reply|
            json.partial! partial: 'comment', reply: true, parent: comment, comment: reply
        end
    else
        json.replies []
    end
end