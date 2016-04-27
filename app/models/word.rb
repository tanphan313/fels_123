class Word < ActiveRecord::Base
  belongs_to :category

  has_many :word_answers, dependent: :destroy
  has_many :lesson_words, dependent: :destroy
  has_many :lessons, through: :lesson_words

  validates :content, presence: true, length: {maximum: 50}
  validate :validate

  accepts_nested_attributes_for :word_answers, reject_if: ->a{a[:content].blank?},
    allow_destroy: true

  scope :by_category, ->category_id{where category_id: category_id if category_id.present?}
  scope :alphabet, ->content{where("id IN(SELECT id FROM words)").order("content")}
  scope :learned, ->user{where("id In(SELECT word_id  FROM lesson_words WHERE lesson_id IN(
		SELECT target_id FROM activities WHERE user_id = #{user.id}
    AND action_type = #{Settings.activities.learned})
    )")}
  scope :not_learned, ->user{where("id NOT IN(SELECT word_id  FROM lesson_words WHERE lesson_id IN(
		SELECT target_id FROM activities WHERE user_id = #{user.id}
    AND action_type = #{Settings.activities.learned})
    )")}
  scope :random_questions, ->{order "RANDOM() LIMIT #{Settings.word.number_per_lesson}"}

  def validate
    errors.add(:word_answers, I18n.t("at_least_one_correct")) if word_answers.select{|answer| answer.correct?}.count < 1
    errors.add(:word_answers, I18n.t("at_least_two_answers")) if word_answers.select{|answer| answer.present?}.count < 2
  end

  def validate_word word_params
    number_of_answer = 0
    number_of_correct_answer = 0
    word_params[:word_answers_attributes].each do |key, par|
      if par["_destroy"] == "false"
        number_of_answer += 1
        if par["correct"] == "1"
          number_of_correct_answer += 1
        end
      end
    end
    errors.add(:word_answers, I18n.t("at_least_two_answers")) unless number_of_answer > 1
    errors.add(:word_answers, I18n.t("at_least_one_correct")) unless number_of_correct_answer == 1
    errors.add(:content, I18n.t("canot_be_blank")) unless word_params[:content].present?
  end
end
