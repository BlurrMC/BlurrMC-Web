if @user != current_user
    if !current_user.following?(@user)
        json.status 'User is not following'
    else
        json.status 'User is following'
    end
else
    json.status 'User must not be themselves!'
end
