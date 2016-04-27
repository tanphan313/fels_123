class WordAnswer < ActiveRecord::Base
  belongs_to :word

  has_many :lesson_words

  before_destroy :reset_word_answer

  validates :content, presence: true

  private
  def reset_word_answer
    if LessonWord.find_by(word_id: word.id)
      LessonWord.find_by(word_id: word.id).update_attribute(:word_answer_id, nil)
    end
  end
end
