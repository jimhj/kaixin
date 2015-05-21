class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :jokes, through: :taggings
  validates_uniqueness_of :slug, on: :create

  scope :hot, -> { order('taggings_count DESC') }

  def hot?
    taggings_count > 2
  end

  before_create do
    self.slug = Pinyin.t(self.name, splitter: '-')
    self.slug = "#{self.id}-#{self.slug}"
  end
end
