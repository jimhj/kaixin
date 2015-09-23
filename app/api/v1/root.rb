module V1
  class Root < Grape::API
    version :v1
    default_error_formatter :json
    content_type :json, 'application/json'
    format :json


    mount V1::Jokes    
  end
end