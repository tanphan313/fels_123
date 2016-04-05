class User < ActiveRecord::Base
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
end
