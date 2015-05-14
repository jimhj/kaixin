class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :jokes, through: :taggings  
end
