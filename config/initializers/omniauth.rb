twitter = YAML::load_file("#{Rails.root}/config/twitter.yml")[Rails.env.to_s].symbolize_keys
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, twitter[:consumer_key], twitter[:consumer_secret]
end