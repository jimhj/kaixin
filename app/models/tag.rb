class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :jokes, through: :taggings  

  def hot?
    taggings_count > 2
  end
end
