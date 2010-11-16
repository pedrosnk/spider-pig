consumer_data = YAML::load( File.open('config/twitter_app.yml') )
Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, consumer_data['consumer_key'].to_s, consumer_data['consumer_secret'].to_s
end