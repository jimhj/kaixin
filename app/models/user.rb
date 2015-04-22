class User < ActiveRecord::Base
  has_secure_password

  has_many :jokes
  has_many :comments
  has_many :photos
  has_many :joke_votings, -> { where(votable_type: 'Joke') }
  has_many :comment_votings, -> { where(votable_type: 'Comment') }

  validates :login, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }  
  validates :mobile, uniqueness: { case_sensitive: false }, allow_blank: true  

  def voted_joke_ids
    joke_votings.pluck :votable_id
  end

  def voted_comment_ids
    comment_votings.pluck :votable_id
  end

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = find_by_id(token.split('$').first)
    (user && Rack::Utils.secure_compare(user.remember_token, token)) ? user : nil
  end  
end
