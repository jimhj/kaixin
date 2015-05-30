class Legacy::Base < ActiveRecord::Base
  self.abstract_class = true
  establish_connection({
    adapter: 'postgresql',
    encoding: 'unicode',
    pool: 5,
    database: 'bx_legacy'
  })
end