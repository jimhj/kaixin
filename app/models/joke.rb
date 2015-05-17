class Joke < ActiveRecord::Base
  include Votable
  mount_uploaders :photos, PhotoUploader
  
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, uniqueness: true, length: { maximum: 40 }, allow_blank: true
  validates :content, presence: true, if: Proc.new { |joke| joke.title.blank? }
  validates :content, uniqueness: true, if: Proc.new { |joke| joke.photos.blank? }

  after_create :update_hot
  after_touch :update_hot

  before_create do
    self.up_votes_count = rand(1000)
    self.down_votes_count = self.up_votes_count * rand(50) / 100
  end

  def tag_list
    tags.pluck(:name)
  end

  def tag_list=(tags)
    tags = tags.split(",").map { |tag| tag.strip }.collect do |tag|
      Tag.find_or_create_by! name: tag
    end

    self.tags = tags
  end

  def tag_with(name)
    if tag_list.include?(name)
      return Tag.find_by(name: name)
    end

    tag = Tag.find_or_create_by!(name: name)
    self.tags << tag
  end

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

  def hot_comment
    comments.where('up_votes_count > 0').order('created_at ASC').first
  end
end
