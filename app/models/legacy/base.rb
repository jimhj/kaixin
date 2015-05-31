class Legacy::Base < ActiveRecord::Base
  self.abstract_class = true

  conf = {
    adapter: 'postgresql',
    encoding: 'unicode',
    pool: 5,
    database: 'bx_legacy'
  }

  if Rails.env.production?
    conf.merge!(user: 'kaixin', password: '_kx_1324')
  end

  establish_connection conf
end