class WordsController < ApplicationController
  def index
    @words = Word.all.paginate page: params[:page],
      per_page: Settings.word.number_per_page
  end
end
