CONFIG   = YAML.load(File.read(File.expand_path('../../config.yml', __FILE__)))[Rails.env]
WEBSITE  = YAML.load(File.read(File.expand_path('../../website.yml', __FILE__)))[Rails.env]
# BAIDU_AD = YAML.load(File.read(File.expand_path('../../baidu_ad.yml', __FILE__)))[Rails.env]
