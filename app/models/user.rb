class User < ActiveRecord::Base
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  has_many :jokes
  has_many :comments
  has_many :votings
  has_many :up_votings
  has_many :down_votings

  validates :login, uniqueness: { case_sensitive: false }, length: { maximum: 20, minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }  
  validates :mobile, uniqueness: { case_sensitive: false }, allow_blank: true  
  # validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: Proc.new { |user| 
  #   user.new_record? or user.password_digest_changed?
  # }  
  
  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = find_by_id(token.split('$').first)
    (user && Rack::Utils.secure_compare(user.remember_token, token)) ? user : nil
  end  

  def admin?
    CONFIG['admin_emails'] && CONFIG['admin_emails'].include?(email)
  end
end
