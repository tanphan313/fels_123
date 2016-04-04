class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :lesson_words
  has_many :words, through: :lesson_words
end
