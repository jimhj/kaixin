module V1
  class Jokes < Grape::API
    resources :jokes do
      desc '获取笑话列表'
      get do
        { hello: 'world' }
      end
    end
  end
end