json.call @user, :username, :name, :bio, :id
json.followers_count @user.followers.count
json.following_count @user.following.count
json.avatar_url user_avatar_url(@user, resize: '150x150^', extent: '150x150', gravity: 'Center')
json.videos @user.videos.reverse, :id
if user_signed_in?
    if !@user.blocking?(current_user)
        json.isblocked false
    else
        json.isblocked true
    end
    if !Report.exists?(reportable_id: @user, actor_id: current_user, reportable_type: "User") && @user != current_user
        json.reported false
    elsif @user == current_user
        json.reported false
    else
        json.reported true
    end
else
    json.isblocked false
    json.reported false
end
