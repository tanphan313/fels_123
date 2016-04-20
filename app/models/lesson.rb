class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words, allow_destroy: true

  after_create :create_lesson_word

  validate :check_number_word

  def number_of_correct_answer
    self.lesson_words.select{|result|
      result.word_answer_id.present? && result.word_answer.correct}.count
  end

  private
  def create_lesson_word
    self.category.words.not_learned(user).random_questions.each do |word|
      self.lesson_words.create word_id: word.id
    end
  end

  def check_number_word
    if self.category.words.not_learned(user)
      .random_questions.count < Settings.word.number_per_lesson
      errors.add :words, I18n.t("not_enough_words")
    end
  end
end
