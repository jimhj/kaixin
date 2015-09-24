module V1
  module Entities 
    class Jokes < Grape::Entity
      expose :id
      expose :title
      expose :content
      expose :photos
    end
  end
end