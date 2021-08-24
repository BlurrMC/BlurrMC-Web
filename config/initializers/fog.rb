CarrierWave.configure do |config| 
    config.fog_credentials = { 
      :provider               => 'AWS', 
      :aws_access_key_id      => ENV['VIDEO_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['VIDEO_SECRET_ACCESS_KEY'], 
      :region =>                'ca-central-1',
      :host => ENV['VIDEO_HOST'],
      :endpoint => ENV['VIDEO_ENDPOINT'],
      :path_style => true
    } 
    config.fog_directory  = 'video' 
    config.fog_public     = false
end 