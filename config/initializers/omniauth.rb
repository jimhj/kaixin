Rails.application.config.middleware.use OmniAuth::Builder do
  require 'weibo'
  require 'qq'
  provider :weibo, CONFIG["weibo_key"], CONFIG["weibo_secret"]
  provider :qq, CONFIG["qq_key"], CONFIG["qq_secret"]
end