class Joke < ActiveRecord::Base
  belongs_to :user
  mount_uploaders :photos, PhotoUploader
end
