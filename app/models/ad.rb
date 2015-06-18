class Ad < ActiveRecord::Base
  validates_presence_of :name, :ad_type, :body

  TYPE = {
    "右侧顶部广告位" => "RIGHT_SIDE_TOP",
    "右侧跟随广告位" => "RIGHT_SIDE_FIXED",
    "内页正文下方广告位" => "DETAIL",
    "内页推荐图片下方广告位" => "RECOMMEND",
    "HOT频道随机广告位" => "HOT"
  }

  scope :published, -> { where(published: true) }
  
  class << self
    Ad::TYPE.values.each do |ad_type|
      define_method(:"#{ad_type.downcase}") do
        published.where(ad_type: ad_type)
      end
    end
  end

end
