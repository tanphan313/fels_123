class WordsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    filter_word
    @categories = Category.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def filter_word
    if params[:filter_params]
      @words = Word.by_category(params[:category_id]).send(params[:filter_params], current_user)
        .paginate page: params[:page],
        per_page: Settings.word.number_per_page
      @words_number = @words.count
    else
      @words = Word.by_category(params[:category_id]).paginate page: params[:page],
        per_page: Settings.word.number_per_page
    end
    @total_word = Word.by_category(params[:category_id]).count
  end
end
