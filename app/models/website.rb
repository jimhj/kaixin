class Website < ActiveRecord::Base
  validates_presence_of :name, :url, on: :create
end
