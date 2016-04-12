class Admin::WordsController < Admin::AdminsController
  def create
    @word = Word.new word_params
    @category = Category.find params[:word][:category_id]
    if @word.save
      flash[:success] = t "create_success"
      redirect_to :back
    else
      flash[:danger] = t "flash_error"
      redirect_to :back
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = t "word_delete_success"
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
