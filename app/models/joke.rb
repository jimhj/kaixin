class Joke < ActiveRecord::Base
  belongs_to :user
  mount_uploaders :photos, PhotoUploader
  include ActiveView::Helpers

  validates :title, uniqueness: true, length: { maximum: 40 }, allow_blank: true
  validates :content, presence: true, if: Proc.new { |joke| joke.title.blank? }
  validates :content, uniqueness: true, if: Proc.new { |joke| joke.photos.blank? }  

  # See https://gist.github.com/xdite/1391980
  def calculate_hot
    score = (up_votes_count - down_votes_count).abs
    order = Math.log10([score, 1].max)

    if score > 0
      sign = 1
    elsif score < 0
      sign = -1
    else
      sign = 0
    end

    seconds = created_at - DateTime.new(1970,1,1)
    long_num = order + sign * seconds / 45000
    (long_num * 10**7).round.to_f / (10**7)
  end

  def update_hot
    # reload because comments_count has been cache in associations
    reload
    update_attribute :hot, calculate_hot
  end  
end
