Rack::Attack.throttle("requests by ip", limit: 25, period: 1) do |request|
    request.ip
end

Rack::Attack.throttle('limit logins per email', limit: 5, period: 1) do |req|
    if req.path == '/users/sessions' && req.post?
      # Normalize the email, using the same logic as your authentication process, to
      # protect against rate limit bypasses.
      req.params['email'].to_s.downcase.gsub(/\s+/, "")
    end
end

Rack::Attack.throttle('limit signups by ip', limit: 25, period: 45) do |req|
    if req.path == '/users/sign_up' && req.post?
      # Normalize the email, using the same logic as your authentication process, to
      # protect against rate limit bypasses.
      req.params['email'].to_s.downcase.gsub(/\s+/, "")
    end
end
