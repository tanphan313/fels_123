class Word < ActiveRecord::Base
  belongs_to :category

  has_many :word_answers, dependent: :destroy
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  validates :content, presence: true, length: {maximum: 50}

  accepts_nested_attributes_for :word_answers, reject_if: ->a{a[:content].blank?},
    allow_destroy: true
end
