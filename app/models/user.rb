class User < ActiveRecord::Base
  attr_accessor :remember_token

  mount_uploader :avatar, ImageUploader

  has_many :activities
  has_many :lessons
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :follower, through: :passive_relationships, source: :follower

  validates :fullname, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def is_following user
    following.include? user
  end

  def follow user
    active_relationships.create followed_id: user.id
  end

  def unfollow user
    active_relationships.find_by(followed_id: user.id).destroy
  end
end
