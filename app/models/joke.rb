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

  enum status: { 
    :pending  => 0,
    :approved => 1, 
    :rejected => 2
  }

  scope :approved, -> {
    where(status: Joke.statuses[:approved])
  }

  scope :hot, -> {
    approved.preload(:user).order('up_votes_count DESC, created_at DESC')
  }

  scope :qutu, -> (limit = 6) {
    approved.hot.where.not(photos: nil).order('created_at DESC').limit(limit)
  }
  
  scope :duanzi, -> (limit = 10) {
    approved.hot.where(photos: nil)
                .where.not(title: nil)
                .where.not(title: '').order('created_at DESC').limit(limit)
  }

  scope :recommend, -> (limit = 10) { 
    find_by_sql(
      <<-SQL
        select * from jokes where recommended is true and photos is not null order by random() limit #{limit};
      SQL
    )
  }

  after_create :update_hot
  after_touch :update_hot

  before_create do
    self.up_votes_count = rand(1000)
    self.down_votes_count = self.up_votes_count * rand(50) / 100
  end

  def self.random
    # See: http://stackoverflow.com/questions/8674718/best-way-to-select-random-rows-postgresql
    sql = <<-SQL
      select * from jokes where random() < 0.01 limit 1;
    SQL

    find_by_sql(sql).first
  end  

  def tag_list
    tags.pluck(:name)
  end

  def tag_list=(tags)
    tags = tags.split(/,|，|\s/).map { |tag| tag.strip }.collect do |tag|
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
    # reload
    update_attribute :hot, calculate_hot
  end

  def hot_comment
    Rails.cache.read("joke:#{self.id}:hot_comment")
  end
end
