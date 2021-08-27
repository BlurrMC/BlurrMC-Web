Recaptcha.configure do |config|
    config.site_key  = ENV['RECAPTCHA_PUBLIC_KEYV2']
    config.secret_key = ENV['RECAPTCHA_PRIVATE_KEYV2']
end
