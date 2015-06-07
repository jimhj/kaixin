class Ad < ActiveRecord::Base
  validates_presence_of :name, :ad_type, :body

  TYPE = {
    "右侧顶部广告位"            => "RIGHT_SIDE_TOP",
    "右侧跟随广告位"            => "RIGHT_SIDE_FIXED",
    "内页正文下方广告位"       => "DETAIL",
    "内页推荐图片下方广告位"    => "RECOMMEND"
  }

  scope :published, -> { where(published: true) }
  
  scope :right_site_top, -> { published.where(ad_type: 'RIGHT_SIDE_TOP') }
end
