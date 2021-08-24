json.following @following.each do |following|
    if !@user.blocking?(following)
        if !following.blocking?(@user)
            json.username following.username
            json.id following.id
            json.name following.name
            json.isblocked false
        else
            json.username following.username
            json.id following.id
            json.name following.name
            json.isblocked true
        end
    else
        json.username following.username
        json.id following.id
        json.name following.name
        json.isblocked true
    end
end
