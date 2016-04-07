class Category < ActiveRecord::Base
  has_many :words
  has_many :lessons

  validates :title, presence: true, length: {minimum:9, maximum: 90}
  validates :description, presence: true, length: {minimum:9, maximum: 255}
end
