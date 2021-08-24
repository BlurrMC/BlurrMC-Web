json.followers @followers.each do |follower|
    if !@user.blocking?(follower)
        if !follower.blocking?(@user)
            json.username follower.username
            json.id follower.id
            json.name follower.name
            json.isblocked false
        else
            json.username follower.username
            json.id follower.id
            json.name follower.name
            json.isblocked true
        end
    else
        json.username follower.username
        json.id follower.id
        json.name follower.name
        json.isblocked true
    end
end



