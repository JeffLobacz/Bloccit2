class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save { self.email = email.downcase }
  before_save { self.role ||= :member }
  before_create :generate_auth_token

  before_save { self.name = self.my_cap }

  def my_cap
    array = []
    array = name.split
    array.each do |f|
      f.capitalize!
    end
    array.join(" ")
  end

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { minimum: 3, maximum: 100 },
            format: { with: EMAIL_REGEX }
  has_secure_password
  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def self.avatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def generate_auth_token
    loop do
      self.auth_token = SecureRandom.base64(64)
      break unless User.find_by(auth_token: auth_token)
    end
  end

end
