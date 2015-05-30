class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :jokes, through: :taggings
  validates_uniqueness_of :slug, on: :create

  scope :hot, -> (limit = 10) { order('taggings_count DESC').limit(10) }

  def hot?
    taggings_count > 10
  end

  before_create do
    self.slug = Pinyin.t(self.name, splitter: '-')
    self.slug = "#{self.id}-#{self.slug}"
  end
end
