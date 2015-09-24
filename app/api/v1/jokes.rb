module V1
  class Jokes < Grape::API
    resources :jokes do
      desc '获取笑话列表'
      get do
        jokes = Joke.all
        present jokes, with: V1::Entities::Jokes
      end
    end
  end
end