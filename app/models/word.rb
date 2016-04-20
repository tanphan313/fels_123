class Word < ActiveRecord::Base
  belongs_to :category

  has_many :word_answers, dependent: :destroy
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  validates :content, presence: true, length: {maximum: 50}

  accepts_nested_attributes_for :word_answers, reject_if: ->a{a[:content].blank?},
    allow_destroy: true

  scope :by_category, ->category_id{where category_id: category_id if category_id.present?}
  scope :alphabet, ->content{where("id IN(SELECT id FROM words)").order("content")}
  scope :learned, ->user{where("id IN(SELECT word_id  FROM lesson_words WHERE lesson_id IN(
    SELECT id FROM lessons WHERE user_id = #{user.id}))")}
  scope :not_learned, ->user{where("id NOT IN(SELECT word_id FROM lesson_words WHERE lesson_id IN(
    SELECT id FROM lessons WHERE user_id = #{user.id}))")}
end
