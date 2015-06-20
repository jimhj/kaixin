Rails.application.config.middleware.use OmniAuth::Builder do
  require 'weibo'
  # require 'qq'
  provider :weibo, CONFIG["weibo_key"], CONFIG["weibo_secret"]
  # provider :qq, Settings.qq_key, Settings.qq_secret
end