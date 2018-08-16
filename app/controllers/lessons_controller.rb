class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_category, only: [:create, :show, :update]
  before_action :find_lesson, only: [:show, :update]
  before_action :correct_user, only: [:update]

  def create
    @lesson = current_user.lessons.create category: @category
    if @lesson.save
      flash[:success] = t "create_success"
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = @lesson.errors.full_messages
      redirect_to @category
    end
  end

  def show
    @point = @lesson.number_of_correct_answer.nil? ? 0 : @lesson.number_of_correct_answer
  end

  def update
    if @lesson.update_attributes lesson_params
      @lesson.create_activity
      flash[:success] = t "update_success"
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = t "flash_error"
      redirect_to category_lessons_path @category, @lesson
    end
  end

  private
  def find_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "no_category_found", id: params[:id]
      redirect_to root_path
    end
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "no_lesson_found", id: params[:id]
      redirect_to root_path
    end
  end

  def correct_user
    unless @lesson.user == current_user
      flash[:danger] = t "not_owner"
      redirect_to [@category, @lesson]
    end
  end

  def lesson_params
    params.require(:lesson).permit lesson_words_attributes:
      [:id, :word_id, :word_answer_id]
  end
end
