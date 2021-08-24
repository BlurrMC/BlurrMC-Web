Recaptcha.configure do |config|
    config.public_key  = ENV['RECAPTCHA_PUBLIC_KEYV2']
    config.private_key = ENV['RECAPTCHA_PRIVATE_KEYV2']
end